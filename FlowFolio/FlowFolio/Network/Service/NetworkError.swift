//
//  NetworkError.swift
//  FolioNetwork
//
//  Created by KOVI on 9/23/25.
//

enum NetworkError: Error {
    case unknown
    case serverError(Int)
    case decodingFailed
}