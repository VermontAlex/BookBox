//
//  AudioPlayerManager.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 08.08.2024.
//

import AVKit

class AudioPlayerManager: ObservableObject {
    
    enum AudioPlayerError: String, Error {
        case invalidUrl = "Fail to retreive audio from Bundle"
        case failAVPLayer = "Fail to create AVAudioPlayer"
        case unknow = "Unknow error"
    }
    
    @Published var isPlaying = false
    @Published var currentAudioTime: TimeInterval = 0.0
    @Published var totalAudioTime: TimeInterval = 0.0
    @Published var audioUrl: URL?
    
    private var audioPlayer: AVAudioPlayer?
    
    init(audioUrl: URL?) {
        self.audioUrl = audioUrl
    }
    
    func setUpAudio() throws {
        guard let url = audioUrl else {
            throw AudioPlayerError.invalidUrl
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.enableRate = true
            audioPlayer?.prepareToPlay()
            totalAudioTime = audioPlayer?.duration ?? 0.0
        } catch {
            throw AudioPlayerError.failAVPLayer
        }
    }
    
    func changeAudioTrack(_ url: URL?) throws {
        stopAudio()
        audioUrl = url
        
        do {
            try setUpAudio()
        } catch(let error) {
            throw error
        }
        
        playAudio()
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
        pauseAudio()
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
