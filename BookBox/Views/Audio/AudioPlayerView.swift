//
//  AudioPlayerView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import AVKit
import Combine

struct AudioPlayerView: View {
    
    private let kMaxPlaybackSpeed: Float = 2.0
    @State private var playbackSpeed: Float = 1.0
    
    @StateObject private var audioPlayerManager: AudioPlayerManager
    
    init(audioPlayerManager: AudioPlayerManager) {
        _audioPlayerManager = StateObject(wrappedValue: audioPlayerManager)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            sliderView
            
            //  Speed view button
            Button("Speed x\(playbackSpeed.timeWith2Decimals())") {
                playbackSpeed = playbackSpeed < kMaxPlaybackSpeed ? playbackSpeed + 0.5 : 1.0
                audioPlayerManager.playBackSpeed(rate: playbackSpeed)
            }
            .foregroundStyle(.black)
            .bold()
            .buttonStyle(BorderedButtonStyle())
            
            audioPlayPannel
        }
        .onAppear {
            audioPlayerManager.setUpAudio()
        }
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
            audioPlayerManager.updateProgress()
        })
        .onDisappear {
            audioPlayerManager.stopAudio()
        }
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
            Text(timeString(time: audioPlayerManager.currentAudioTime))
                .frame(width: 40)
                
                Slider(value: Binding(get: {
                    audioPlayerManager.currentAudioTime
                }, set: { newValue in
                    audioPlayerManager.seekAudio(to: newValue)
                }), in: 0...audioPlayerManager.totalAudioTime)
                .tint(.blue)
            
            Text(timeString(time: audioPlayerManager.totalAudioTime - audioPlayerManager.currentAudioTime))
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
                audioPlayerManager.seekAudio(to: 0.0)
            } label: {
                Image(systemName: "backward.end.fill")
                    .font(.title)
                    .foregroundStyle(.black)
            }
            
            //  Backward 5
            Button {
                audioPlayerManager.currentAudioTime -= 5
                
                if audioPlayerManager.currentAudioTime > 0 {
                    audioPlayerManager.seekAudio(to: audioPlayerManager.currentAudioTime)
                } else {
                    audioPlayerManager.currentAudioTime = 0
                    audioPlayerManager.seekAudio(to: audioPlayerManager.currentAudioTime)
                }
            } label: {
                Image(systemName: "gobackward.5")
            }
            
            //  Play/Pause
            Button {
                audioPlayerManager.isPlaying ? audioPlayerManager.pauseAudio() : audioPlayerManager.playAudio()
            } label: {
                ZStack {
                    audioPlayerManager.isPlaying ?
                    Image(systemName: "pause.fill"):
                    Image(systemName: "play.fill")
                }
                .animation(.bouncy, value: audioPlayerManager.isPlaying)
            }

            //  Forward 10
            Button {
                audioPlayerManager.currentAudioTime += 10
                audioPlayerManager.seekAudio(to: audioPlayerManager.currentAudioTime)
            } label: {
                Image(systemName: "goforward.10")
            }
            
            //  Forward end
            Button {
                audioPlayerManager.seekAudio(to: audioPlayerManager.totalAudioTime)
            } label: {
                Image(systemName: "forward.end.fill")
            }
        }
        .font(.title)
        .foregroundStyle(.black)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AudioPlayerView(audioPlayerManager: AudioPlayerManager(audioUrl: BooksMock.book1AudioUrl))
}
