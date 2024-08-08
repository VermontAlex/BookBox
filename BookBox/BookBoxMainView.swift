//
//  ContentView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookBoxMainView: View {
    
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
        TabView {
            ForEach(viewStore) { bookViewStore in
                BookItemView(book: bookViewStore)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .transition(.slide)
    }
}

extension ViewStoreOf: Identifiable {}

#Preview {
    BookBoxMainView(store: [Store(initialState: BookReducer.State(), reducer: { BookReducer() })])
}
