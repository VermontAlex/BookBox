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
    
    private enum PlayerImageConstants {
        static let backwardEnd = Image(systemName: "backward.end.fill")
        static let backwardFive = Image(systemName: "gobackward.5")
        static let pause = Image(systemName: "pause.fill")
        static let play = Image(systemName: "play.fill")
        static let forwardTen = Image(systemName: "goforward.10")
        static let forwardEnd = Image(systemName: "forward.end.fill")
    }
    
    @StateObject var audioPlayerManager: AudioPlayerManager
    @Binding var chapterNumber: Int
    var maxChapters: Int
    
    @State private var playbackSpeed: Float = 1.0
    private let kMoveBackward = 5.0
    private let kMoveForward = 10.0
    private let kMaxPlaybackSpeed: Float = 2.0
    
    var body: some View {
        VStack(spacing: 20) {
            sliderView
            playBackSpeedView
            audioPlayPannel
        }
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
            audioPlayerManager.updateProgress()
        })
        .onDisappear {
            audioPlayerManager.stopAudio()
        }
    }
    
    private func timeIntervalToString(_ time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%2d:%02d", minute, seconds)
    }
}

extension AudioPlayerView {
    
    private var sliderView: some View {
        HStack {
            Text(timeIntervalToString(audioPlayerManager.currentAudioTime))
                .frame(width: 40)
            
            //  MARK: TO-DO - Replace on UISlider
            Slider(value: Binding(get: {
                audioPlayerManager.currentAudioTime
            }, set: { newValue in
                audioPlayerManager.seekAudio(to: newValue)
            }), in: 0...audioPlayerManager.totalAudioTime)
            .tint(.blue)
            
            Text(timeIntervalToString(audioPlayerManager.totalAudioTime - audioPlayerManager.currentAudioTime))
                .frame(width: 40)
        }
        .padding()
        .font(.subheadline)
        .foregroundStyle(.gray)
    }
    
    private var playBackSpeedView: some View {
        Button("Speed x\(playbackSpeed.timeWith2Decimals())") {
            playbackSpeed = playbackSpeed < kMaxPlaybackSpeed ? playbackSpeed + 0.5 : 1.0
            audioPlayerManager.playBackSpeed(rate: playbackSpeed)
        }
        .foregroundStyle(.black)
        .bold()
        .buttonStyle(BorderedButtonStyle())
    }
    
    private var audioPlayPannel: some View {
        HStack(spacing: 20) {
            //  Backward chapter
            Button {
                let newValue = chapterNumber - 1
                chapterNumber = newValue < 0 ? 0 : newValue
            } label: {
                PlayerImageConstants.backwardEnd
                    .font(.title)
                    .foregroundStyle(.black)
            }
            
            //  Backward 5
            Button {
                audioPlayerManager.currentAudioTime -= kMoveBackward
                
                if audioPlayerManager.currentAudioTime > 0 {
                    audioPlayerManager.seekAudio(to: audioPlayerManager.currentAudioTime)
                } else {
                    audioPlayerManager.currentAudioTime = 0
                    audioPlayerManager.seekAudio(to: audioPlayerManager.currentAudioTime)
                }
            } label: {
                PlayerImageConstants.backwardFive
            }
            
            //  Play/Pause
            Button {
                audioPlayerManager.isPlaying ? audioPlayerManager.pauseAudio() : audioPlayerManager.playAudio()
            } label: {
                ZStack {
                    audioPlayerManager.isPlaying ?
                    PlayerImageConstants.pause:
                    PlayerImageConstants.play
                }
                .animation(.bouncy, value: audioPlayerManager.isPlaying)
            }
            
            //  Forward 10
            Button {
                audioPlayerManager.currentAudioTime += kMoveForward
                audioPlayerManager.seekAudio(to: audioPlayerManager.currentAudioTime)
            } label: {
                PlayerImageConstants.forwardTen
            }
            
            //  Forward Chapter
            Button {
                let newValue = chapterNumber + 1
                chapterNumber = newValue >= maxChapters ? maxChapters : newValue
            } label: {
                PlayerImageConstants.forwardEnd
            }
        }
        .font(.title)
        .foregroundStyle(.black)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AudioPlayerView(audioPlayerManager: AudioPlayerManager(audioUrl: nil), chapterNumber: .constant(0), maxChapters: 10)
}
