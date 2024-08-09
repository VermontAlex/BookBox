//
//  BookBoxApp.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct BookBoxApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView(store: BooksMock.getBookStoresMock())
        }
    }
}
