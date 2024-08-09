//
//  BookAudioView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookAudioView: View {
    
    @StateObject private var audioPlayerManager: AudioPlayerManager
    
    var book: ViewStoreOf<BookReducer>
    @State var chapterNumber: Int
    
    @State private var showAlert = false
    @State private var error: AudioPlayerManager.AudioPlayerError?
    
    init(book: ViewStoreOf<BookReducer>, chapterNumber: Int) {
        _audioPlayerManager = StateObject(wrappedValue: AudioPlayerManager(audioUrl: book.chapters[chapterNumber].audioUrl))
        self.book = book
        self._chapterNumber = State(initialValue: chapterNumber)
    }
    
    var body: some View {
        VStack {
            
            AudioHeaderView(book: book, chapterNumber: $chapterNumber)
            
            if error == nil {
                AudioPlayerView(audioPlayerManager: audioPlayerManager, chapterNumber: $chapterNumber, maxChapters: book.chapters.count - 1)
            } else {
                Text("Something went wrong with audio, please try again later")
                    .padding()
                
                //  MARK: TO-DO - Handle error with Analytics
            }
            
        }
        .onAppear {
            setupAudioPlayer()
        }
        .onChange(of: chapterNumber) {
            do {
                try audioPlayerManager.changeAudioTrack(book.chapters[chapterNumber].audioUrl)
            } catch(let error) {
                handleAudioError(error: error)
            }
        }
        .alert(isPresented: $showAlert) {
            createAlert(message: error?.rawValue ?? "")
        }
    }
    
    private func setupAudioPlayer() {
        do {
            try audioPlayerManager.setUpAudio()
        } catch(let error) {
            handleAudioError(error: error)
        }
    }
    
    private func handleAudioError(error: Error) {
        self.error = error as? AudioPlayerManager.AudioPlayerError ?? AudioPlayerManager.AudioPlayerError.unknow
        showAlert = true
    }
    
    private func createAlert(message: String) -> Alert {
        Alert(
            title: Text("Error"),
            message: Text(message),
            dismissButton: .default(Text("OK"))
        )
    }
}
