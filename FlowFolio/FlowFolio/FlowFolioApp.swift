//
//  FlowFolioApp.swift
//  FlowFolio
//
//  Created by 조성민 on 9/15/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct FlowFolioApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(store: Store(initialState: LoginFeature.State()) {
                LoginFeature()
            })
        }
    }
}
