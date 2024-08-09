//
//  BookChapterView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 08.08.2024.
//

import SwiftUI
//  MARK: - TO-DO - Chapter view with parsed chapter description for future reader
struct BookChapterView: View {
    
    var chapterText: String
    
    var body: some View {
        Text(chapterText)
            .font(.largeTitle)
            .padding()
    }
}

#Preview {
    BookChapterView(chapterText: "")
}
