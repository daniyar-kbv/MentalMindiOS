//
//  MeditationSoundsViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation
import UIKit

class MeditationSoundsViewController: BaseViewController {
    lazy var mainView = MeditationSoundsView()
    var superVc: MeditationDetailViewController?
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        if let index = superVc?.currentMeditaion {
            mainView.menVoiceButton.isHidden = superVc?.collection?.meditations?[index].fileMaleVoice == nil
            mainView.womenVoiceButton.isHidden = superVc?.collection?.meditations?[index].fileFemaleVoice == nil
            if mainView.voiceStack.arrangedSubviews.contains(where: { $0.isHidden == true }) {
                mainView.voiceStack.arrangedSubviews.first(where: { $0.isHidden == false })?.isUserInteractionEnabled = false
            }
        }
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        for button in mainView.voiceStack.arrangedSubviews as? [VoiceButton] ?? [] {
            button.isActive = superVc?.voiceType == button.type
            button.onTap = voiceTapped(_:)
        }
        
        mainView.slider.setValue(superVc?.backgroundPlayer?.volume ?? 0, animated: false)
        mainView.slider.addTarget(self, action: #selector(sliderValueChanged(_:_:)), for: .valueChanged)
    }
    
    func voiceTapped(_ voice: VoiceTypes) {
        superVc?.voiceType = voice
    }
    
    @objc func sliderValueChanged(_ slider: UISlider, _ event: UIEvent) {
        let touch = event.allTouches?.first
        superVc?.backgroundPlayer?.volume = slider.value
        switch touch?.phase {
        case .ended:
            AppShared.sharedInstance.backgroundVolume = slider.value
        default:
            break
        }
    }
}

extension MeditationSoundsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BackgroundMusic.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundMusicCell.reuseIdentifier, for: indexPath) as! BackgroundMusicCell
        cell.music = BackgroundMusic.allCases[indexPath.row]
        cell.isActive = cell.music == superVc?.backgroundMusic
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? BackgroundMusicCell {
                cell.isActive = i == indexPath.row
                if i == indexPath.row {
                    superVc?.backgroundMusic = cell.music ?? .wayToHarmony
                }
            }
        }
    }
}
