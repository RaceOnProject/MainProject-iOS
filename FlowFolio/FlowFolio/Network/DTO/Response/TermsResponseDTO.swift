//
//  TermsResponseDTO.swift
//  FolioNetwork
//
//  Created by KOVI on 9/23/25.
//

struct TermsResponseDTO: Decodable {
    let success: Bool
    let message: String
    let data: TermsDataDTO
}

struct TermsDataDTO: Decodable {
    let terms: [TermDTO]
}

struct TermDTO: Decodable {
    let term: String
    let url: String
    let code: String
    let required: Bool
}

extension TermDTO {
    func toEntity() -> Term {
        return Term(
            term: term,
            url: url,
            code: code,
            required: self.required
        )
    }
}