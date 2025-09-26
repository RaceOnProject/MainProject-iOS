//
//  CompanyResponseDTO.swift
//  FolioNetwork
//
//  Created by KOVI on 9/23/25.
//

struct CompanyResponseDTO: Decodable {
    let success: Bool
    let message: String
    let data: CompanyDTO
}

struct CompanyDTO: Decodable {
    let id: Int
    let companyName: String
    let permissionDate: String
    let siteFullAddress: String
    let roadNameAddress: String
    let latitude: Double
    let longitude: Double
    let totalRating: Double
    let following: Bool
}

extension CompanyDTO {
    func toEntity() -> Company {
        return Company(
            id: id,
            companyName: companyName,
            permissionDate: permissionDate,
            siteFullAddress: siteFullAddress,
            roadNameAddress: roadNameAddress,
            latitude: latitude,
            longitude: longitude,
            totalRating: totalRating,
            following: following
        )
    }
}