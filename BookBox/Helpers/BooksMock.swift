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
    static let book1AudioUrl = Bundle.main.url(forResource: "mockaudio", withExtension: "mp3")
    static let chapterDescription = "Design in not how it looks, but how it works"
    static let chapter = BookChapter(id: 3, chapterTitle: "Chapter Title when tap opens chapter description", chapterDescription: "Design in not how it looks, but how it works",
                                                  chapterNumber: 10)
    
    static let bookId2 = "BookLogo2"
    
    static let bookId3 = "BookLogo3"
    
    static func getBookStoresMock() -> [StoreOf<BookReducer>] {
        return [Store(initialState: BookReducer.State(id: BooksMock.bookId1, 
                                                      audioUrl: BooksMock.book1AudioUrl,
                                                      chapters: [BooksMock.chapter, BooksMock.chapter, BooksMock.chapter, BooksMock.chapter, BooksMock.chapter, BooksMock.chapter, BooksMock.chapter]),
                      reducer: { BookReducer() }),
                
                Store(initialState: BookReducer.State(id: BooksMock.bookId2, 
                                                      audioUrl: BooksMock.book1AudioUrl,
                                                      chapters: [BooksMock.chapter, BooksMock.chapter, BooksMock.chapter, BooksMock.chapter, BooksMock.chapter]),
                      reducer: { BookReducer() }),
                
                Store(initialState: BookReducer.State(id: BooksMock.bookId3, 
                                                      audioUrl: BooksMock.book1AudioUrl,
                                                      chapters: [BooksMock.chapter, BooksMock.chapter, BooksMock.chapter, BooksMock.chapter, BooksMock.chapter]),
                      reducer: { BookReducer() })
        ]
    }
}
