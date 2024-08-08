//
//  BookView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookView: View {
    
    let book: ViewStoreOf<BookReducer>
    
    var body: some View {
        VStack {
            Image(book.id)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300)
            Text("Key point 2 of 10")
                .foregroundStyle(Color.gray)
                .font(.subheadline)
                .bold()
            Text("book.chapter")
        }
    }
}

//#Preview(traits: .sizeThatFitsLayout) {
//    BookView(imageId: BooksMock.bookId1)
//}
