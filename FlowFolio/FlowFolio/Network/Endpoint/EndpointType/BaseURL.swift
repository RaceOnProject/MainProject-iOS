//
//  BaseURL.swift
//  FolioNetwork
//
//  Created by KOVI on 9/23/25.
//

import Foundation

enum NetworkConfig {
    static let baseURL: URL = {
        guard
            let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
            let baseURL = URL(string: urlString)
        else {
            fatalError("Config의 BaseURL값을 읽어올 수 없음")
        }
        return baseURL
    }()

    static let exampleToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI2OSIsImlhdCI6MTc1ODYxNDQyOSwiZXhwIjoxNzU4NjE4MDI5fQ.SZx8u3-BxIvwmE9h_XtwX5K8Rev5LwH6Ak-fVRPwCFUnAgAC8r0DhQWe9vVPFH43JgXL1zxKIjGaz3msFj1P_Q"
}