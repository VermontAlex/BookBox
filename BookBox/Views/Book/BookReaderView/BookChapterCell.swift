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
            NavigationLink(destination: BookChapterView(chapterText: bookChapter.chapterDescription)) {
                Text(bookChapter.chapterTitle)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BookChapterCell(bookChapter: BooksMock.createBookChapters()[0])
}
