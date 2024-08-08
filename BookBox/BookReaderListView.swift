//
//  BookReaderListView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 08.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookReaderListView: View {
    
    var chapters: [BookChapter]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(chapters) { chapter in
                    BookChapterCell(bookChapter: chapter)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    BookReaderListView(chapters: [BooksMock.chapter])
}
