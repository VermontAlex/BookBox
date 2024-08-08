//
//  BookItemView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookItemView: View {
    
    var book: ViewStoreOf<BookReducer>
    
    var body: some View {
        VStack {
            Spacer()
            BookView(imageId: book.id)
            
            AudioPlayerView(audioPlayerManager: AudioPlayerManager(audioUrl: book.audioUrl))
            
            Spacer()
            RoundedSegmentControlView()
            Spacer()
        }
    }
    
    
}

//#Preview {
//    BookItemView(book: ViewStoreOf(Book.s, observe: <#T##(State) -> _##(State) -> _##(_ state: State) -> _#>))
//}
