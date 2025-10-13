//
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

    @Test("실패케이스 -(400 Bad Request) 일 때, NetworkError.serverError(400) 뱉는지 여부")
    func testServerError400() async throws {
        defer { MockURLProtocol.mockResponseHandler = nil }
        
        // Given
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: configuration)
        MockURLProtocol.mockResponseHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 400,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        let sut = NetworkService(session: mockSession)
        let request = URLRequest(url: URL(string: "https://api.example.com/test")!)

        // When
        do {
            let _: Dummy = try await sut.request(request)
            assertionFailure("이쪽 접근되면 안됨")
        } catch let error as NetworkError {
            // Then
            switch error {
            case .serverError(let code):
                #expect(code == 400)
            default:
                assertionFailure("이쪽 접근되면 안됨")
            }
        }
    }


    @Test("실패케이스 -(디코딩 실패) 일 때, NetworkError.decodingFailed 뱉는지 여부")
    func testDecodingFailure() async throws {
        defer { MockURLProtocol.mockResponseHandler = nil }
        
        // Given
        let invalidJsonData = "{ I'M INVALID JSON }".data(using: .utf8)!
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
            return (response, invalidJsonData)
        }

        let sut = NetworkService(session: mockSession)
        let request = URLRequest(url: URL(string: "https://api.example.com/user")!)

        do {
            // When
            let json: MockMessageResponse = try await sut.request(request)
            assertionFailure("이쪽 접근되면 안됨")
        } catch let error as NetworkError {
            // Then
            switch error {
            case .decodingFailed:
                #expect(true)
            default:
                assertionFailure("이쪽 접근되면 안됨")
            }
        }
    }
}
