//
//  FlowFolioApp.swift
//  FlowFolio
//
//  Created by 조성민 on 9/15/25.
//

import SwiftUI
import ComposableArchitecture
import KakaoSDKCommon

@main
struct FlowFolioApp: App {
    init() {
        let kakaoNativeAppKey = ServiceEnvironment.KAKAO_NATIVE_APP_KEY.value
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(store: Store(initialState: LoginFeature.State()) {
                LoginFeature()
            })
        }
    }
}
