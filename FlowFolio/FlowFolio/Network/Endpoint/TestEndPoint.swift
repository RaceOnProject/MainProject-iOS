//
//  Untitled.swift
//  FolioNetwork
//
//  Created by KOVI on 9/23/25.
//

import Foundation

enum TestEndpoint {
    /// GET & Param Query 로 요청하는 폼
    case searchCompany(ID: Int)
    /// POST & body JSON 을 담아서 요청하는 폼
    case duplicateCheck(DuplicateCheckRequestDTO)
    /// GET & plain 하게 요쳥하는 폼
    case terms
}

extension TestEndpoint: EndpointType {
    var path: String {
        switch self {
        case .searchCompany(let id): "/api/companies/\(id)"
        case .duplicateCheck: "/api/users/nickname-verify"
        case .terms: "/api/auth/terms"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .searchCompany: .get
        case .duplicateCheck: .post
        case .terms: .get
        }
    }

    var headers: [String: String]? {
        switch self {
        case .searchCompany: ["Authorization": NetworkConfig.exampleToken]
        case .duplicateCheck: ["Content-Type": "application/json"]
        case .terms: nil
        }
    }

    var requestType: RequestType {
        switch self {
        case .searchCompany: .plain
        case .duplicateCheck(let requestModel): .body(requestModel)
        case .terms: .plain
        }
    }
}