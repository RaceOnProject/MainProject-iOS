//
//  NetworkLogger.swift
//  FlowFolio
//
//  Created by KOVI on 9/26/25.
//

import Foundation

protocol NetworkLogger {
    func requestWillStart(_ request: URLRequest)
    func requestDidFinish(_ response: URLResponse?, data: Data?, error: Error?)
}

extension NetworkLogger {
    func requestWillStart(_ request: URLRequest) {
        print(
            "🚀 [REQUEST] [\(request.httpMethod ?? "UNKNOWN")] \(request.url?.absoluteString ?? "No URL")"
        )

        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("📋 [HEADERS] \(headers)")
        }

        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("📦 [BODY] \(bodyString)")
        }

        print("─────────────────────────────────────")
    }

    func requestDidFinish(_ response: URLResponse?, data: Data?, error: Error?) {
        if let error = error {
            print("❌ [ERROR] \(error)")
            print("❌ [ERROR DESCRIPTION:] \(error.localizedDescription)")
            print("─────────────────────────────────────")
            return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            print("⚠️ [RESPONSE] Invalid response type")
            print("─────────────────────────────────────")
            return
        }
        let statusIcon = httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 ? "✅" : "❌"
        print(
            "\(statusIcon) [RESPONSE] \(httpResponse.statusCode) \(httpResponse.url?.absoluteString ?? "")"
        )
        if let data = data,
           let responseString = String(data: data, encoding: .utf8) {
            let truncatedResponse = responseString.count > 500
                ? String(responseString.prefix(500)) + "... (truncated)"
                : responseString
            print("📄 [DATA] \(truncatedResponse)")
        }
        print("─────────────────────────────────────")
    }
}
