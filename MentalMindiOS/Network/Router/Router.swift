//
//  APIManager.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request<T: Response>(_ route: EndPoint, returning: T.Type, completion: @escaping(_ error:String?,_ module: T?)->())
}

class MyRouter<EndPoint: EndPointType>: NetworkRouter{
    var imageKeys: [String] = ["profile_image"]
    
    func prepareRequest(_ route: EndPoint) -> (HTTPHeaders?, Loader?) {
        let headers = { () -> HTTPHeaders? in
            var headers = route.header
            if let additionalHeaders = route.additionalHeaders{
                for header in additionalHeaders{
                    headers?.add(header)
                }
            }
            return headers
        }()
        let loader = route.showLoader ?
            Loader.show() :
            nil
        return (headers, loader)
    }
    
    func request<T>(_ route: EndPoint, returning: T.Type, completion: @escaping(_ error:String?,_ module: T?)->()) where T : Response {
        let (headers, loader) = prepareRequest(route)
        let taskId = UIApplication.shared.beginBackgroundTask()
        AF.request(route.baseURL.appendingPathComponent(route.path), method: route.httpMethod, parameters: route.parameters, encoding: Encoder.getEncoding(route.encoding), headers: headers).responseData() { response in
            UIApplication.shared.endBackgroundTask(taskId)
            self.dataCompletion(response: response, loader: loader) { error, response in
                completion(error, response)
            }
        }
    }
    
    func upload<T>(_ route: EndPoint, returning: T.Type, completion: @escaping(_ error:String?,_ module: T?)->()) where T : Response {
        let (headers, loader) = prepareRequest(route)
        let taskId = UIApplication.shared.beginBackgroundTask()
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in route.parameters ?? [String: Any]() {
                    print(key, value)
                    if let url = value as? URL {
                        multipartFormData.append(url, withName: key)
                    } else if let data = "\(value)".data(using: String.Encoding.utf8, allowLossyConversion: false) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            },
            to: route.baseURL.appendingPathComponent(route.path),
            usingThreshold: .zero,
            method: route.httpMethod,
            headers: headers, interceptor: nil,
            fileManager: .default
        ).responseData(completionHandler: { response in
            self.dataCompletion(response: response, loader: loader) { error, response in
                completion(error, response)
            }
            UIApplication.shared.endBackgroundTask(taskId)
        })
    }

    func dataCompletion<T>(response: AFDataResponse<Data>, loader: Loader?, completion: @escaping(_ error:String?,_ module: T?)->()) where T : Response {
        guard let res = response.response else {
            showError(response.error?.localizedDescription, loader: loader, response)
            completion(response.error?.localizedDescription, nil)
            return
        }
        let result = self.handleNetworkResponse(res)
        switch result {
        case .success:
            guard let responseData = response.data else {
                showError(NetworkResponse.failed.localized, loader: loader, response)
                completion(NetworkResponse.failed.localized, nil)
                return
            }
            do {
//                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                print(jsonData)
                let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                if let error = apiResponse.error {
                    loader?.setProgress(100)
                    UIApplication.topViewController()?.showAlert(title: error)
                    completion(error, nil)
                    return
                }
                loader?.setProgress(100)
                completion(nil, apiResponse)
            }
            catch {
                showError(NetworkResponse.unableToDecode.localized, loader: loader, response)
                completion(NetworkResponse.unableToDecode.localized, nil)
            }
        case .failure(let error, let errorCompletion):
            showError(error, loader: loader, response, errorCompletion)
            completion(error, nil)
        }
    }
    
    func showError(_ error: String?, loader: Loader?, _ response: AFDataResponse<Data>, _ completion: (() -> Void)? = nil) {
        loader?.setProgress(100)
        print("Error: \(error)/nRequest: \(response.response?.statusCode ?? 0); \(response.request?.url?.absoluteString ?? "")")
        ErrorView.addToView(text: error ?? "", completion: completion)
    }
    
    enum Result<String>{
        case success
        case failure(String, (() -> Void)? = nil)
    }

    enum NetworkResponse:String {
        case success
        case failed = "Произошла ошибка\nПопробуйте еще раз"
        case unableToDecode = "Мы не смогли обработать ответ"
        case serverError = "Ошибка сервера"
        
        var localized: String {
            return self.rawValue.localized
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 401: return .failure("Вам необходимо снова авторизоваться",
                                  { AppShared.sharedInstance.signOut() })
        case 200...499: return .success
        case 500...599: return .failure(NetworkResponse.serverError.localized)
        default: return .failure(NetworkResponse.failed.localized)
        }
    }
    
}
