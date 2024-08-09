//
//  AudioHeaderView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct AudioHeaderView: View {
    
    let book: ViewStoreOf<BookReducer>
    @Binding var chapterNumber: Int
    
    var body: some View {
        VStack {
            Image(book.id)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300)
            
            if chapterNumber <= book.chapters.count && chapterNumber >= 0 {
                Text("Key point \(chapterNumber + 1) of \(book.chapters.count)")
                    .textCase(.uppercase)
                    .foregroundStyle(Color.gray)
                    .font(.footnote)
                    .bold()
                
                HStack {
                    Spacer()
                    Text("\(book.chapters[chapterNumber].chapterTitle)")
                        .bold()
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
            }
        }
    }
}
