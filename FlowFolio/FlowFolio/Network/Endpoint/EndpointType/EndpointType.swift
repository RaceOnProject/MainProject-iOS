//
//  EndpointType.swift
//  FolioNetwork
//
//  Created by KOVI on 9/23/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum RequestType {
    case plain
    case body(_ body: Encodable)
    case multipart(Data)
}

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var requestType: RequestType { get }
}

extension EndpointType {
    var baseURL: URL {
        return NetworkConfig.baseURL
    }

    func buildRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach({ request.setValue($1, forHTTPHeaderField: $0) })
        switch requestType {
        case .plain: break
        case .body(let body):
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                assertionFailure("Body 인코딩에 실패")
            }
        case .multipart(let data):
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var body = Data()
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(data)
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            request.httpBody = body
        }
        return request
    }
}
