//
//  MockURLSession.swift
//  FlowFolio
//
//  Created by KOVI on 10/14/25.
//

import Foundation
@testable import FlowFolio

// MARK: - Dummy
struct MockMessageResponse: Decodable {
    let message: String
}

struct Dummy: Decodable {}

// MARK: - Mock URLSession
final class MockURLSession: URLSessionProtocol, @unchecked Sendable {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.mockData = data
        self.mockResponse = response
        self.mockError = error
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }

        guard let data = mockData, let response = mockResponse else {
            throw URLError(.badServerResponse)
        }

        return (data, response)
    }
}
