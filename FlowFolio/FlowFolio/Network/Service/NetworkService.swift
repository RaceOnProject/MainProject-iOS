//
//  NetworkService.swift
//  FolioNetwork
//
//  Created by KOVI on 9/26/25.
//

import Foundation

protocol URLSessionProtocol: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

final class NetworkService: NetworkLogger, Sendable {
    /// URLSession을 직접적으로 의존하지 않도록 함 (이유: 테스트를 위해서)
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(
        _ request: URLRequest
    ) async throws -> T {
        requestWillStart(request)

        var responseData: Data?
        var urlResponse: URLResponse?
        var requestError: Error?

        defer {
            requestDidFinish(urlResponse, data: responseData, error: requestError)
        }

        do {
            let (data, response) = try await session.data(for: request)
            responseData = data
            urlResponse = response

            guard let httpResponse = response as? HTTPURLResponse else {
                requestError = NetworkError.unknown
                throw NetworkError.unknown
            }
            guard 200...299 ~= httpResponse.statusCode else {
                requestError = NetworkError.serverError(httpResponse.statusCode)
                throw NetworkError.serverError(httpResponse.statusCode)
            }

            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch let error as NetworkError {
            requestError = error
            throw error
        } catch {
            requestError = NetworkError.decodingFailed
            throw NetworkError.decodingFailed
        }
    }
}
