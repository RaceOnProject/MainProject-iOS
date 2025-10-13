//
//  MockURLProtocol.swift
//  FlowFolio
//
//  Created by KOVI on 10/13/25.
//

import Foundation

// MARK: - Dummy
struct MockMessageResponse: Decodable {
    let message: String
}

struct Dummy: Decodable {}

// MARK: - Mock URLProtocol
// URLSession이 보내는 요청을 가로채서 직접 응답 `mockResponseHandler` 을 만들어 돌려 주려고 설계한 객체
final class MockURLProtocol: URLProtocol {
    /// 가짜응답 Mock
    static var mockResponseHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    /// 요청을 가로챌지 여부를 결정
    override class func canInit(with request: URLRequest) -> Bool {
        return true // 항상 가로챔
    }
    /// 요청을 정규화 하는 메서드인데 별도 정규화 과정 없이 request 그대로 사용함.
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    /// 실제 응답 전송이 시작되는 지점.
    override func startLoading() {
        guard let handler = MockURLProtocol.mockResponseHandler else {
            assertionFailure("Mock 응답 핸들러가 설정되지 않았음 - 테스트 코드 확인")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed) // response 전달
            client?.urlProtocol(self, didLoad: data) // data 전달
            client?.urlProtocolDidFinishLoading(self) // 완료 알림
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    /// 응답 정지 시
    override func stopLoading() { }
}
