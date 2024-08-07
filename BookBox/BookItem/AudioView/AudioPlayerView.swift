//
//  AudioPlayerView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import AVKit

struct AudioPlayerView: View {
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false

    @State private var audioSpeed = 1
    
    @State private var currentAudioTime: TimeInterval = 00.0
    @State private var totalAudioTime: TimeInterval = 0.0
    
    @State private var endAudioValue = 03.42 //  AudioValue from audio
    @State private var endAudio = 03.42 //  AudioValueToShow
    
    var body: some View {
        VStack(spacing: 20) {
            sliderView
            
            //  Speed view button
            Button("Speed x\(audioSpeed)") {
                audioSpeed += 1
            }
            .foregroundStyle(.black)
            .bold()
            .buttonStyle(BorderedButtonStyle())
            
            audioPlayPannel
        }
        .onAppear {
            setUpAudio()
        }
    }
    
    func setUpAudio() {
        guard let url = Bundle.main.url(forResource: "mockaudio", withExtension: "mp3") else {
            print("Fail to retreive audio")
            return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
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
        audioPlayer?.currentTime = time
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
            Text(currentAudioTime.timeWith2Decimals())
            
//            Slider(value: $currentAudioTime,
//                   in: 0.0...endAudioValue)
            Slider(value: Binding(get: {
                currentAudioTime
            }, set: { newValue in
                seekAudio(to: newValue)
            }), in: 0...totalAudioTime)
            
            Text(endAudioValue.timeWith2Decimals())
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
                currentAudioTime = 00.00
            } label: {
                Image(systemName: "backward.end.fill")
                    .font(.title)
                    .foregroundStyle(.black)
            }
            
            //  Backward 5
            Button {
                if currentAudioTime > 0.00 {
                    currentAudioTime -= 0.05
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
                currentAudioTime += 0.1
            } label: {
                Image(systemName: "goforward.10")
            }
            
            //  Forward end
            Button {
                currentAudioTime = endAudioValue
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
