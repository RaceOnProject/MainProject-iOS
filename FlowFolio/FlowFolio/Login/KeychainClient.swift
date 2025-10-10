//
//  KeychainClient.swift
//  FlowFolio
//
//  Created by 조성민 on 10/8/25.
//

import ComposableArchitecture
import Security
import Foundation

struct KeychainClient: Sendable {
    var save: @Sendable (String, String) -> Void
    var get: @Sendable (String) -> String?
    var delete: @Sendable (String) -> Void
}

// 서버에서 받은 AccessToken, RefreshToken 관리 클라이언트
extension KeychainClient: DependencyKey {
    static let liveValue = Self(
        save: { value, key in
            guard let data = value.data(using: .utf8) else {
                assertionFailure("KeychainClient Save Failed - Wrong Data")
                return
            }
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            SecItemDelete(query as CFDictionary)
            SecItemAdd(query as CFDictionary, nil)
        },
        get: { key in
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecReturnData as String: true,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
            
            var result: AnyObject?
            SecItemCopyMatching(query as CFDictionary, &result)
            
            guard let data = result as? Data else { return nil }
            return String(data: data, encoding: .utf8)
        },
        delete: { key in
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ]
            
            SecItemDelete(query as CFDictionary)
        }
    )
}

extension DependencyValues {
    var keychainClient: KeychainClient {
        get { self[KeychainClient.self] }
        set { self[KeychainClient.self] = newValue }
    }
}
