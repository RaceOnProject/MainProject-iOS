//
//  DuplicateCheckResponseDTO.swift
//  FolioNetwork
//
//  Created by KOVI on 9/23/25.
//

struct DuplicateCheckResponseDTO: Decodable {
    let success: Bool
    let message: String
}

extension DuplicateCheckResponseDTO {
    func toEntity() -> DuplicateCheckResult {
        return DuplicateCheckResult(
            success: success,
            message: message
        )
    }
}