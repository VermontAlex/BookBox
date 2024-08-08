//
//  BookItemView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI

struct BookItemView: View {
    
    var book: Book
    
    var body: some View {
        VStack {
            Spacer()
            BookView(imageId: book.id)
            AudioPlayerView()
            Spacer()
            RoundedSegmentControlView()
            Spacer()
        }
    }
}

#Preview {
    BookItemView(book: Book(id: BooksIdMock.book1))
}
