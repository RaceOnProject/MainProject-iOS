//  NetworkServiceTests.swift
//  NetworkServiceTests
//
//  Created by KOVI on 9/29/25.
//

import Testing
import Foundation
@testable import FlowFolio

// MARK: - NetworkService Tests
struct NetworkServiceTests {
    
    @Test("성공케이스 -(200응답/JSONDATA) 일 때, 메시지를 정상 디코딩")
    func testSuccessfulRequest() async throws {
        defer { MockURLProtocol.mockResponseHandler = nil }
        
        // Given
        let expectMessage = "ok"
        let expectJson: Data = #"{"message":"ok"}"#.data(using: .utf8)!
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: configuration)
        MockURLProtocol.mockResponseHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, expectJson)
        }
        let sut = NetworkService(session: mockSession)
        let request = URLRequest(url: URL(string: "https://api.example.com/test")!)

        // When
        let result: MockMessageResponse = try await sut.request(request)

        // Then
        #expect(result.message == expectMessage)
    }
