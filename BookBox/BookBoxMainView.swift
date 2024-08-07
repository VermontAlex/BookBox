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
            VStack {
                Spacer()
                BookView(imageId: "BookLogo")
                AudioPlayerView()
                Spacer()
                RoundedSegmentControlView()
                Spacer()
            }
            
            //  Book2
            VStack {
                Spacer()
                BookView(imageId: "BookLogo")
                AudioPlayerView()
                Spacer()
                RoundedSegmentControlView()
                Spacer()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    BookBoxMainView()
}
