//
//  BookAudioView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookAudioView: View {
    
    var book: ViewStoreOf<BookReducer>
    
    var body: some View {
        VStack {
            BookView(book: book)
            
            AudioPlayerView(audioPlayerManager: AudioPlayerManager(audioUrl: book.audioUrl))
        }
    }
}

//#Preview {
//    BookItemView(book: ViewStoreOf(Book.s, observe: <#T##(State) -> _##(State) -> _##(_ state: State) -> _#>))
//}
