//
//  BookReaderView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 08.08.2024.
//

import SwiftUI

struct BookReaderView: View {
    
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
    BookReaderView(chapters: BooksMock.createBookChapters())
}
