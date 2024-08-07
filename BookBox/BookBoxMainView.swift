//
//  ContentView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI

struct BookBoxMainView: View {
    
    var dataSource = [BookView(imageId: "BookLogo"), BookView(imageId: "BookLogo")]
    
    var body: some View {
        TabView {
            //  Book1
            VStack(spacing: 0) {
                BookView(imageId: "BookLogo")
                AudioPlayerView()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    BookBoxMainView()
}
