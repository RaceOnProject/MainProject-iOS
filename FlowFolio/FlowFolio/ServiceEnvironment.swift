//
//  ServiceEnvironment.swift
//  FlowFolio
//
//  Created by 조성민 on 10/4/25.
//

import Foundation

/// Config 값 관리 열거형
enum ServiceEnvironment {
    case KAKAO_NATIVE_APP_KEY
    case BASE_URL
    
    var value: String {
        switch self {
        case .KAKAO_NATIVE_APP_KEY:
            guard let value = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String else {
                assertionFailure("KAKAO_NATIVE_APP_KEY Not Found")
                return ""
            }
            return value
        
        case .BASE_URL:
            guard let value = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String else {
                assertionFailure("BASE_URL Not Found")
                return ""
            }
            return value
        }
    }
}
