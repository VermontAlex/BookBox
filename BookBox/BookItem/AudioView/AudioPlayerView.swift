//
//  AudioPlayerView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import AVKit

struct AudioPlayerView: View {
    
    private var kMaxPlaybackSpeed = 3
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false

    @State private var playbackSpeed = 1
    
    @State private var currentAudioTime: TimeInterval = 0.0
    @State private var totalAudioTime: TimeInterval = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            sliderView
            
            //  Speed view button
            Button("Speed x\(playbackSpeed)") {
                guard isPlaying else { return }
                if playbackSpeed < kMaxPlaybackSpeed {
                    playbackSpeed += 1
                } else {
                    playbackSpeed = 1
                }

                playBackSpeed(rate: Float(playbackSpeed))
            }
            .foregroundStyle(.black)
            .bold()
            .buttonStyle(BorderedButtonStyle())
            
            audioPlayPannel
        }
        .onAppear {
            setUpAudio()
        }
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
            updateProgress()
        })
        .onDisappear {
            stopAudio()
        }
    }
    
    func setUpAudio() {
        guard let url = Bundle.main.url(forResource: "mockaudio", withExtension: "mp3") else {
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
    
    private func playAudio() {
        guard !isPlaying else { return }
        audioPlayer?.play()
        isPlaying.toggle()
    }
    
    private func pauseAudio() {
        guard isPlaying else { return }
        audioPlayer?.pause()
        isPlaying.toggle()
    }
    
    private func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    private func updateProgress() {
        guard let audioPlayer = audioPlayer else { return }
        currentAudioTime = audioPlayer.currentTime
    }
    
    private func seekAudio(to time: TimeInterval) {
        pauseAudio()
        audioPlayer?.currentTime = time
        playAudio()
    }
    
    private func playBackSpeed(rate: Float) {
        audioPlayer?.play()
        audioPlayer?.rate = rate
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%2d:%02d", minute, seconds)
    }
}

extension AudioPlayerView {
    
    var sliderView: some View {
        HStack {
            Text(timeString(time: currentAudioTime))
                .frame(width: 40)
                
                Slider(value: Binding(get: {
                    currentAudioTime
                }, set: { newValue in
                    seekAudio(to: newValue)
                }), in: 0...totalAudioTime)
                .tint(.blue)
            
            Text(timeString(time: totalAudioTime - currentAudioTime))
                .frame(width: 40)
        }
        .padding()
        .font(.subheadline)
        .foregroundStyle(.gray)
    }
    
    var audioPlayPannel: some View {
        //  Play/Pause buttons
        HStack(spacing: 20) {
            //  Backward start
            Button {
                seekAudio(to: 0.0)
            } label: {
                Image(systemName: "backward.end.fill")
                    .font(.title)
                    .foregroundStyle(.black)
            }
            
            //  Backward 5
            Button {
                currentAudioTime -= 5
                
                if currentAudioTime > 0 {
                    seekAudio(to: currentAudioTime)
                } else {
                    currentAudioTime = 0
                    seekAudio(to: currentAudioTime)
                }
            } label: {
                Image(systemName: "gobackward.5")
            }
            
            //  Play/Pause
            Button {
                isPlaying ? pauseAudio() : playAudio()
            } label: {
                ZStack {
                    isPlaying ?
                    Image(systemName: "pause.fill"):
                    Image(systemName: "play.fill")
                }
                .animation(.bouncy, value: isPlaying)
            }

            //  Forward 10
            Button {
                currentAudioTime += 10
                seekAudio(to: currentAudioTime)
            } label: {
                Image(systemName: "goforward.10")
            }
            
            //  Forward end
            Button {
                seekAudio(to: totalAudioTime)
            } label: {
                Image(systemName: "forward.end.fill")
            }
        }
        .font(.title)
        .foregroundStyle(.black)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AudioPlayerView()
}
