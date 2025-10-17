//
//  BaseURL.swift
//  FolioNetwork
//
//  Created by KOVI on 9/23/25.
//

import Foundation

enum NetworkConfig {
    static let baseURL: URL = {
        guard let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let baseURL = URL(string: urlString) else {
            assertionFailure("Config의 BaseURL값을 읽어올 수 없음")
            return URL(string: "")!
        }
        return baseURL
    }()

    static let exampleToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI2OSIsImlhdCI6MTc2MDQxOTA0NiwiZXhwIjoxNzYwNDIyNjQ2fQ.RH_Kc46u3HUh01OBwQ7TwW5B_oKXDEzwfNDhc8rlNhGq7ilUkatHDoJ7WMNTiS62t-TVeDwKV4mJyzgM_oKowA"
}
