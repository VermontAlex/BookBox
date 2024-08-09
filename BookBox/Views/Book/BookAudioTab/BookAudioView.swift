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
    
    init(book: ViewStoreOf<BookReducer>, chapterNumber: Int) {
        _audioPlayerManager = StateObject(wrappedValue: AudioPlayerManager(audioUrl: book.chapters[chapterNumber].audioUrl))
        self.book = book
        self._chapterNumber = State(initialValue: chapterNumber)
    }
    
    var body: some View {
        VStack {
            BookView(book: book, chapterNumber: $chapterNumber)
            AudioPlayerView(audioPlayerManager: audioPlayerManager, chapterNumber: $chapterNumber, maxChapters: book.chapters.count - 1)
        }
        .onChange(of: chapterNumber){
            audioPlayerManager.updateAudioUrl(book.chapters[chapterNumber].audioUrl)
        }
    }
}

//#Preview {
//    BookItemView(book: ViewStoreOf(Book.s, observe: <#T##(State) -> _##(State) -> _##(_ state: State) -> _#>))
//}
