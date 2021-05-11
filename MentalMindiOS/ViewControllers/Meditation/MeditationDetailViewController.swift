//
//  MeditationDetailViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 08.12.2020.
//

import Foundation
import UIKit
import AVFoundation
import RxSwift

class MeditationDetailViewController: BaseViewController {
    lazy var mainView = MeditationDetailView()
    lazy var viewModel: MeditaionDetailViewModel = {
        let view = MeditaionDetailViewModel()
        view.vc = self
        return view
    }()
    lazy var disposeBag = DisposeBag()
    
    var collection: CollectionDetail?
    var subscriptionId: Int?
    var voiceType: VoiceTypes = .female {
        didSet {
            mainView.dictorVoiceButton.value.text = voiceType.title
            var stringUrl: String? = nil
            switch voiceType {
            case .female:
                stringUrl = collection?.meditations?[currentMeditaion].fileFemaleVoice
            case .male:
                stringUrl = collection?.meditations?[currentMeditaion].fileMaleVoice
            }
            if let url = URL(string: stringUrl ?? "") {
                removeMeditationObserver()
                currentSec = 0
                meditationItem = AVPlayerItem(url: url)
                meditationPlayer = AVPlayer(playerItem: meditationItem)
                addMeditationObserver()
                if isPlaying {
                    meditationPlayer?.play()
                }
            }
        }
    }
    var backgroundMusic: BackgroundMusic = .wayToHarmony {
        didSet {
            mainView.backgoundMusicButton.value.text = backgroundMusic.name
            backgroundPlayer = try! AVAudioPlayer(contentsOf: backgroundMusic.url)
            backgroundPlayer?.prepareToPlay()
            backgroundPlayer?.numberOfLoops = 1000
            backgroundPlayer?.volume = AppShared.sharedInstance.backgroundVolume ?? 0.2
            if isPlaying {
                backgroundPlayer?.play()
            }
        }
    }
    var currentMeditaion: Int = 0 {
        didSet {
            if let url = URL(string: collection?.meditations?[currentMeditaion].fileFemaleVoice ?? "") {
                removeMeditationObserver()
                currentSec = 0
                meditationItem = AVPlayerItem(url: url)
                meditationPlayer = AVPlayer(playerItem: meditationItem)
                addMeditationObserver()
            }
            currentMeditaion == 0 ? mainView.backControllButton.disable() : mainView.backControllButton.enable()
            (currentMeditaion == (collection?.meditations?.count ?? 0) - 1) ||
            (
                collection?.meditations?[
                    collection?.meditations?.count ?? 0 > currentMeditaion + 1 ? currentMeditaion + 1 : 0
                ].fileFemaleVoice == nil &&
                collection?.meditations?[
                    collection?.meditations?.count ?? 0 > currentMeditaion + 1 ? currentMeditaion + 1 : 0
                ].fileMaleVoice == nil
            ) ?
                mainView.nextControllButton.disable() :
                mainView.nextControllButton.enable()
            
            isFavoforite = (AppShared.sharedInstance.user?.favoriteMeditations?.contains(where: {
                $0.meditationId == self.collection?.meditations?[currentMeditaion].id
            })) ?? false
            
            mainView.meditation = collection?.meditations?[currentMeditaion]
        }
    }
    var isFavoforite: Bool = false {
        didSet {
            mainView.likeButton.isActive = isFavoforite
        }
    }
    var isPlaying = false {
        didSet {
            if isPlaying {
                if timeObserverToken == nil {
                    addMeditationObserver()
                }
                meditationPlayer?.play()
                backgroundPlayer?.play()
            } else {
                meditationPlayer?.pause()
                backgroundPlayer?.pause()
            }
            mainView.playControllButton.isActive = isPlaying
        }
    }
    
    var backgroundPlayer: AVAudioPlayer?
    var meditationPlayer: AVPlayer?
    var meditationItem: AVPlayerItem?
    var timeObserverToken: Any?
    var currentSec: Float = 0 {
        didSet {
            mainView.currentTimeLabel.text = Int(currentSec).toTime()
            mainView.slider.setValue(currentSec, animated: true)
            if currentSec > Float(collection?.meditations?[currentMeditaion].duration ?? 0) {
                stopPlayers()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        mainView.likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        mainView.backControllButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        mainView.nextControllButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        mainView.playControllButton.addTarget(self, action: #selector(playbuttonTapped), for: .touchUpInside)
        mainView.slider.addTarget(self, action: #selector(sliderDown), for: .touchDown)
        mainView.slider.addTarget(self, action: #selector(eventChanged(_:_:)), for: .valueChanged)
        for button in mainView.buttonsStack.arrangedSubviews as? [MeditationInnerButton] ?? [] {
            button.addTarget(self, action: #selector(openSoundSettings(_:)), for: .touchUpInside)
        }
        
        backgroundPlayer = try! AVAudioPlayer(contentsOf: BackgroundMusic.wayToHarmony.url)
        backgroundPlayer?.prepareToPlay()
        backgroundPlayer?.numberOfLoops = 1000
        backgroundPlayer?.volume = AppShared.sharedInstance.backgroundVolume ?? 0.2
        
        do {
            try AVAudioSession.sharedInstance()
                                  .setCategory(AVAudioSession.Category.playback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        isPlaying = true
        
        bind()
    }
    
    func bind() {
        viewModel.action.subscribe(onNext: { object in
            DispatchQueue.main.async {
                guard let meditation = self.collection?.meditations?[self.currentMeditaion], let user = AppShared.sharedInstance.user else { return }
                switch object {
                case .add:
                    self.mainView.likeButton.isActive = true
                    user.favoriteMeditations?.append(
                        Meditation(meditationId: meditation.id, meditationName: meditation.name, meditationDescription: meditation.description_, meditationFileMaleVoice: meditation.fileMaleVoice, meditationFileFemaleVoice: meditation.fileFemaleVoice, collectionId: self.collection?.id, fileImage: self.collection?.fileImage, duration: meditation.duration)
                    )
                case .delete:
                    self.mainView.likeButton.isActive = false
                    if let index = user.favoriteMeditations?.firstIndex(where: { $0.meditationId == meditation.id }) {
                        user.favoriteMeditations?.remove(at: index)
                    }
                }
                AppShared.sharedInstance.user = user
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !((AppShared.sharedInstance.navigationController.topViewController is MeditationRateViewController) || (AppShared.sharedInstance.navigationController.topViewController is MeditationSoundsViewController)){
            backgroundPlayer?.pause()
            meditationPlayer?.pause()
            backgroundPlayer = nil
            meditationPlayer = nil
            do {
                try AVAudioSession.sharedInstance()
                                      .setCategory(AVAudioSession.Category.playback)
                print("AVAudioSession Category Playback OK")
                do {
                    try AVAudioSession.sharedInstance().setActive(false)
                    print("AVAudioSession is Active")
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            sendHistory()
        }
    }
    
    @objc func backTapped() {
        sendHistory()
        currentMeditaion -= 1
        isPlaying = true
    }
    
    @objc func nextTapped() {
        sendHistory()
        currentMeditaion += 1
        isPlaying = true
    }
    
    @objc func likeTapped() {
        mainView.likeButton.isActive ? viewModel.favorite(action: .delete) : viewModel.favorite(action: .add)
    }
    
    @objc func openSoundSettings(_ button: UIButton) {
        button.showTap()
        let vc = MeditationSoundsViewController()
        vc.superVc = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func playbuttonTapped() {
        isPlaying.toggle()
    }
    
    @objc func sliderDown() {
        removeMeditationObserver()
    }
    
    @objc func eventChanged(_ slider: UISlider, _ event: UIEvent) {
        let touch = event.allTouches?.first
        mainView.currentTimeLabel.text = Int(slider.value).toTime()
        switch touch?.phase {
        case .ended:
            let timeScale = CMTimeScale(NSEC_PER_SEC)
            meditationPlayer?.seek(to: CMTime(seconds: Double(mainView.slider.value), preferredTimescale: timeScale)) { finished in
                if finished {
                    self.addMeditationObserver()
                }
            }
        default:
            break
        }
    }
    
    func addMeditationObserver() {
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        var count = 0
        timeObserverToken = meditationPlayer?.addPeriodicTimeObserver(forInterval: time,
                                                          queue: .main) {
            [weak self] time in
            count += 1
            if count > 2 {
                self?.currentSec = Float(time.seconds)
            }
        }
    }

    func removeMeditationObserver() {
        guard let timeObserverToken = timeObserverToken else { return }
        meditationPlayer?.removeTimeObserver(timeObserverToken)
        self.timeObserverToken = nil
    }
    
    func stopPlayers() {
        mainView.slider.setValue(0, animated: true)
        isPlaying = false
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        meditationPlayer?.seek(to: CMTime(seconds: 0, preferredTimescale: timeScale))
        backgroundPlayer?.currentTime = 0
        removeMeditationObserver()
        let vc = MeditationRateViewController()
        vc.superVc = self
        navigationController?.pushViewController(vc, animated: true)
        sendHistory()
    }
    
    func sendHistory() {
        guard let id = collection?.meditations?[currentMeditaion].id else { return }
        viewModel.sendHistory(meditation: id, seconds: Int(currentSec))
    }
}
