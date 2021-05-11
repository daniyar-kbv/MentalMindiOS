//
//  URL.swift
//  GOALSTER
//
//  Created by Daniyar on 9/22/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

extension URL {
    func getQueryStringParameter(param: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
