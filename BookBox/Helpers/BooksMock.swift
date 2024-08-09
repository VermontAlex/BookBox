//
//  BooksIdMock.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 08.08.2024.
//

import Foundation
import ComposableArchitecture

enum BooksMock {
    static let bookId1 = "BookLogo1"
    static let bookId2 = "BookLogo2"
    static let bookId3 = "BookLogo3"
    
    static func getBookStoresMock() -> [StoreOf<BookReducer>] {
        return [Store(initialState: BookReducer.State(id: BooksMock.bookId1,
                                                      chapters: BooksMock.createBookChapters()),
                      reducer: { BookReducer() }),
                Store(initialState: BookReducer.State(id: BooksMock.bookId2, chapters: BooksMock.createBookChapters()), reducer: { BookReducer() }),
                
                Store(initialState: BookReducer.State(id: BooksMock.bookId3, chapters: BooksMock.createBookChapters()), reducer: { BookReducer() })
        ]
    }
    
    static func createBookChapters() -> [BookChapter] {
        var chapters: [BookChapter] = []
        
        let mockAudio1 = Bundle.main.url(forResource: "mockaudio", withExtension: "mp3")
        let mockAudio2 = Bundle.main.url(forResource: "mockaudio2", withExtension: "mp3")
        
        let mockDifferentTitle1 = "Mock Chapter title number:"
        let mockDifferentTitle2 = "Title for this chapter is different, number:"
        
        for obj in 0...9 {
            chapters.append(BookChapter(id: obj,
                                        chapterTitle: "\(obj % 2 == 0 ? mockDifferentTitle1 : mockDifferentTitle2) \(obj + 1). Short one sentence title per chapter in our book. Design in not how it looks, but how it works",
                                        chapterDescription: "This text is from Book Mock object, so it will show us chapter. But it still neds to be implemented with better UI",
                                        chapterNumber: obj, audioUrl: obj % 2 == 0 ? mockAudio1 : mockAudio2))
        }
        
        return chapters
    }
    
}
