//
//  ServiceEnvironment.swift
//  FlowFolio
//
//  Created by 조성민 on 10/4/25.
//

/// Config 값 관리 열거형
enum ServiceEnvironment {
    case KAKAO_NATIVE_APP_KEY
    
    var value: String {
        switch self {
        case .KAKAO_NATIVE_APP_KEY:
            return Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as! String
        }
    }
}
