//
//  KakaoLoginClient.swift
//  FlowFolio
//
//  Created by 조성민 on 10/4/25.
//

import ComposableArchitecture
import KakaoSDKUser
import KakaoSDKAuth

struct KakaoLoginClient: Sendable {
    var login: @Sendable () async throws -> KakaoLoginToken
}

/// Kakao SDK의 Sendable하지 않은 OAuthToken 대신 필요한 정보만 추출하여 Sendable한 모델로 사용
struct KakaoLoginToken: Sendable { // TODO: 서버에서 필요한 필드에 맞춰 변경
    let accessToken: String
    let refreshToken: String
}

/// 카카오 로그인에 사용되는 클라이언트
extension KakaoLoginClient: DependencyKey {
    static let liveValue = Self(
        login: {
            // 카카오톡으로 로그인
            if UserApi.isKakaoTalkLoginAvailable() {
                return try await withCheckedThrowingContinuation { continuation in
                    Task { @MainActor in
                        UserApi.shared.loginWithKakaoTalk { token, error in
                            if let error = error {
                                continuation.resume(throwing: error)
                            } else if let token = token {
                                continuation.resume(returning: KakaoLoginToken(
                                    accessToken: token.accessToken,
                                    refreshToken: token.refreshToken
                                ))
                            } else {
                                continuation.resume(throwing: KakaoLoginError.noToken)
                            }
                        }
                    }
                }
            } else {
                // 카카오계정으로 로그인
                return try await withCheckedThrowingContinuation { continuation in
                    Task { @MainActor in
                        UserApi.shared.loginWithKakaoAccount { token, error in
                            if let error = error {
                                continuation.resume(throwing: error)
                            } else if let token = token {
                                continuation.resume(returning: KakaoLoginToken(
                                    accessToken: token.accessToken,
                                    refreshToken: token.refreshToken
                                ))
                            } else {
                                continuation.resume(throwing: KakaoLoginError.noToken)
                            }
                        }
                    }
                }
            }
        }
    )
}

extension DependencyValues {
    var kakaoLoginClient: KakaoLoginClient {
        get { self[KakaoLoginClient.self] }
        set { self[KakaoLoginClient.self] = newValue }
    }
}

enum KakaoLoginError: Error {
    case noToken
}
