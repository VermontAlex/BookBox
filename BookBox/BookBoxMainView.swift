//
//  ContentView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI

struct BookBoxMainView: View {
    
    var dataSource = [Book(id:"BookLogo"), 
                      Book(id:"BookLogo2"),
                      Book(id:"BookLogo3")]
    
    var body: some View {
        TabView {
            ForEach(dataSource) { bookId in
                BookItemView(book: bookId)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .transition(.slide)
    }
}

#Preview {
    BookBoxMainView()
}
