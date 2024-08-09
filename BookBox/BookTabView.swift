//
//  BookTabView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookTabView: View {
    
    private var store: [StoreOf<BookReducer>]
    private var viewStore: [ViewStoreOf<BookReducer>]
    @State var isAudioTabShown = true
    
    init(store: [StoreOf<BookReducer>]) {
        self.store = store
        self.viewStore = []
        store.forEach({
            viewStore.append(ViewStore($0, observe: { $0 }))
        })
    }
    
    var body: some View {
        if isAudioTabShown {
            audioTabView
                .transition(.move(edge: .leading))
        } else {
            BookReaderListView(chapters: viewStore[0].chapters)
                .transition(.move(edge: .trailing))
        }
        
        RoundedSegmentControlView(isLeftSelected: $isAudioTabShown)
    }
}

extension BookTabView {
    var audioTabView: some View {
        TabView {
            ForEach(viewStore) { bookViewStore in
                BookAudioView(book: bookViewStore, chapterNumber: 0)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

extension ViewStoreOf: Identifiable {}

//#Preview {
//    BookTabView(store:
//                        [Store(
//                            initialState: BookReducer.State(
//                                chapter: BookChapterReducer()),
//                            reducer: { BookReducer() })])
//}
