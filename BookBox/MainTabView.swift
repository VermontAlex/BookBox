//
//  MainTabView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

extension ViewStoreOf: Identifiable {}

struct MainTabView: View {
    
    @State var isAudioTabShown = true
    
    private var store: [StoreOf<BookReducer>]
    private var viewStore: [ViewStoreOf<BookReducer>]
    
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
            readerTabView
                .transition(.move(edge: .trailing))
        }
        
        RoundedSegmentControlView(isLeftSelected: $isAudioTabShown)
    }
}

extension MainTabView {
    var audioTabView: some View {
        TabView {
            ForEach(viewStore) { bookViewStore in
                BookAudioView(book: bookViewStore, chapterNumber: 0)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
    
    var readerTabView: some View {
        BookReaderView(chapters: viewStore.first?.chapters ?? [])
    }
}

#Preview {
    MainTabView(store:[Store(initialState: BookReducer.State(chapters: BooksMock.createBookChapters()), reducer: { BookReducer() })])
}
