//
//  LoginFeature.swift
//  FlowFolio
//
//  Created by 조성민 on 9/24/25.
//

import ComposableArchitecture
import KakaoSDKUser
import AuthenticationServices

@Reducer
struct LoginFeature {
    @ObservableState
    struct State: Equatable {
        var errorMessage: String? // TODO: 실패 메시지 담아서 어떻게 보여줄지 결정
    }
    
    enum Action {
        case tryKakaoLogin
        case kakaoLoginResult(Result<KakaoLoginToken, Error>)
        case appleLoginResult(Result<ASAuthorization, Error>)
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
                // TODO: 카카오 로그인 완료 후 처리
                dump(token)
                return .none
                
            case .kakaoLoginResult(.failure(let error)):
                return .send(.loginFailed(error.localizedDescription))
                
            case .appleLoginResult(.success(let auth)):
                if let credential = auth.credential as? ASAuthorizationAppleIDCredential,
                   let authorizationCodeData = credential.authorizationCode,
                   let identityTokenData = credential.identityToken,
                   let authorizationCode = String(data: authorizationCodeData, encoding: .utf8),
                   let identityToken = String(data: identityTokenData, encoding: .utf8) {
                    // TODO: 로그인 완료 후 authorizationCode, identityToken 서버로 전송 및 처리
                    print(authorizationCode + "\n\n" + identityToken)
                }
                return .none
            case .appleLoginResult(.failure(let error)):
                
                return .send(.loginFailed(error.localizedDescription))
            case .loginFailed(let message):
                dump(message)
                state.errorMessage = message
                return .none
            }
        }
    }
}
