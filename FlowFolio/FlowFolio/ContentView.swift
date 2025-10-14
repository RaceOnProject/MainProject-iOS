//
//  ContentView.swift
//  FlowFolio
//
//  Created by 조성민 on 9/15/25.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    @Dependency(\.testAPIService) var testAPIService

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                await testAllAPIs()
            }
        }
    }

    private func testAllAPIs() async {
        print("=== TestAPI 호출 시작 ===")
        do {
            let company = try await testAPIService.searchCompany(id: 1512587)
            let result = try await testAPIService.duplicateCheck(nickname: "testuser")
            let terms = try await testAPIService.terms()
        } catch {
            print(error)
        }
    }
}

#Preview {
    ContentView()
}
