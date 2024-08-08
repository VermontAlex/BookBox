//
//  AudioPlayerManager.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 08.08.2024.
//

import AVKit

class AudioPlayerManager: ObservableObject {
    
    @Published var isPlaying = false
    @Published var currentAudioTime: TimeInterval = 0.0
    @Published var totalAudioTime: TimeInterval = 0.0
    
    private var audioUrl: URL?
    private var audioPlayer: AVAudioPlayer?
    
    init(audioUrl: URL?) {
        self.audioUrl = audioUrl
        setUpAudio()
    }
    
    func setUpAudio() {
        guard let url = audioUrl else {
            print("Fail to retreive audio")
            return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.enableRate = true
            audioPlayer?.prepareToPlay()
            totalAudioTime = audioPlayer?.duration ?? 0.0
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func playAudio() {
        guard !isPlaying else { return }
        audioPlayer?.play()
        isPlaying.toggle()
    }
    
    func pauseAudio() {
        guard isPlaying else { return }
        audioPlayer?.pause()
        isPlaying.toggle()
    }
    
    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    func updateProgress() {
        guard let audioPlayer = audioPlayer else { return }
        currentAudioTime = audioPlayer.currentTime
    }
    
    func seekAudio(to time: TimeInterval) {
        pauseAudio()
        audioPlayer?.currentTime = time
        playAudio()
    }
    
    func playBackSpeed(rate: Float) {
        audioPlayer?.rate = rate
        guard isPlaying else { return }
        audioPlayer?.play()
    }
    
}
