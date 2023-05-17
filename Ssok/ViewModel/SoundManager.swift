//
//  SoundManager.swift
//  Ssok
//
//  Created by 김민 on 2023/05/17.
//

import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    let musics = ["DingDingMusic", "TocaTocaMusic"]
    
    func playMusic() {
        guard let path = Bundle.main.path(forResource: musics.randomElement()!, ofType: "mp3") else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1 // 무한반복
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("음악 재생 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
    func pauseMusic() {
        audioPlayer?.stop()
    }
}

