//
//  LoginFeature.swift
//  FlowFolio
//
//  Created by 조성민 on 9/24/25.
//

import ComposableArchitecture
import KakaoSDKUser

@Reducer
struct LoginFeature {
    @ObservableState
    struct State: Equatable {
        var errorMessage: String? // TODO: 실패 메시지 담아서 어떻게 보여줄지 결정
    }
    
    enum Action {
        case tryKakaoLogin
        case kakaoLoginResult(Result<KakaoLoginToken, Error>)
        case loginFailed(String)
    }
    
    @Dependency(\.kakaoLoginClient) var kakaoLoginClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tryKakaoLogin:
                return .run { send in
                    await send(.kakaoLoginResult(
                        Result { try await kakaoLoginClient.login() }
                    ))
                }
                
            case .kakaoLoginResult(.success(let token)):
                // TODO: 카카오 로그인 완료 후 토큰 처리
                return .none
                
            case .kakaoLoginResult(.failure(let error)):
                return .send(.loginFailed(error.localizedDescription))
                
            case .loginFailed(let message):
                state.errorMessage = message
                return .none
            }
        }
    }
}
