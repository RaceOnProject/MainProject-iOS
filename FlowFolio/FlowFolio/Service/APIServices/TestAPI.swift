//
//  TestAPI.swift
//  FolioNetwork
//
//  Created by KOVI on 9/23/25.
//

import Dependencies
import ComposableArchitecture

protocol TestAPIService {
    func searchCompany(id: Int) async throws -> Company
    func duplicateCheck(nickname: String) async throws -> DuplicateCheckResult
    func terms() async throws -> [Term]
}

private enum TestAPIServiceKey: DependencyKey {
    static let liveValue: any TestAPIService = DefaultTestAPIService()
}

extension DependencyValues {
    var testAPIService: any TestAPIService {
        get { self[TestAPIServiceKey.self] }
        set { self[TestAPIServiceKey.self] = newValue }
    }
}

struct DefaultTestAPIService: TestAPIService {

    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    func searchCompany(id: Int) async throws -> Company {
        let request = TestEndpoint.searchCompany(ID: id).buildRequest()
        let response: CompanyResponseDTO = try await networkService.request(request)
        return response.data.toEntity()
    }

    func duplicateCheck(nickname: String) async throws -> DuplicateCheckResult {
        let requestModel = DuplicateCheckRequestDTO(nickname: nickname)
        let request = TestEndpoint.duplicateCheck(requestModel).buildRequest()
        let response: DuplicateCheckResponseDTO = try await networkService.request(request)
        return response.toEntity()
    }

    func terms() async throws -> [Term] {
        let request = TestEndpoint.terms.buildRequest()
        let response: TermsResponseDTO = try await networkService.request(request)
        return response.data.terms.map { $0.toEntity() }
    }
}