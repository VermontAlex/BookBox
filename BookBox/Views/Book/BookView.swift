//
//  BookView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI

struct BookView: View {
    
    let imageId: String
    
    var body: some View {
        VStack {
            Image(imageId)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300)
            Text("Key point 2 of 10")
                .foregroundStyle(Color.gray)
                .font(.subheadline)
                .bold()
            Text("Design in not how it looks, but how it works")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BookView(imageId: BooksIdMock.book1)
}
