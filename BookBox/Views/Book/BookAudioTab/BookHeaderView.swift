//
//  BookHeaderView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookHeaderView: View {
    
    let book: ViewStoreOf<BookReducer>
    @Binding var chapterNumber: Int
    
    var body: some View {
        VStack {
            Image(book.id)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300)
            
            if chapterNumber <= book.chapters.count && chapterNumber >= 0 {
                Text("Key \(chapterNumber + 1) of \(book.chapters.count)")
                    .foregroundStyle(Color.gray)
                    .font(.subheadline)
                    .bold()
                
                Text("\(book.chapters[chapterNumber].chapterTitle)")
            }
        }
    }
}

