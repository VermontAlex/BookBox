//
//  BookReducer.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct BookReducer {
    
    struct State: Equatable {
        let id: String
        let audioUrl: URL?
        
        init(id: String = BooksMock.bookId1, audioUrl: URL? = BooksMock.book1AudioUrl) {
            self.id = id
            self.audioUrl = audioUrl
        }
    }
    
    enum Action {
        //  MARK: To-Do: Actions need to be implemented when more technical detailes received
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        //  MARK: To-Do: Reduce need to be implemented when more technical detailes received
    }
}
