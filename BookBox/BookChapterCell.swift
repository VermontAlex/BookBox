//
//  BookChapterCell.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 08.08.2024.
//

import SwiftUI

struct BookChapterCell: View {
    
    var bookChapter: BookChapter
    
    var body: some View {
        HStack {
            NavigationLink(destination: detailView) {
                Text(bookChapter.chapterTitle)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
            }
        }
    }
}

extension BookChapterCell {
    var detailView: some View {
        Text("Work in progress, here you will see whole chapter. Waiting soon")
            .font(.largeTitle)
            .padding()
    }
}

//#Preview(traits: .sizeThatFitsLayout) {
//    BookChapterCell(bookChapter: BooksMock.chapter)
//}
