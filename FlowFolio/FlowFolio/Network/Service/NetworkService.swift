//
//  NetworkService.swift
//  FolioNetwork
//
//  Created by KOVI on 9/26/25.
//

import Foundation

final class NetworkService: NetworkLogger, Sendable {
    private let session: URLSession

    init(session: URLSession = URLSession(configuration: .default)) {
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
