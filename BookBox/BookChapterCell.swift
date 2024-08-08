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
        Text("This is the new screen")
            .font(.largeTitle)
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BookChapterCell(bookChapter: BooksMock.chapter)
}
