//
//  ProductDTOModel.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation

/// 네트워크 또는 JSON 파일에서 디코딩할 데이터 전송 객체(DTO)
///
///

typealias ProductDTOModel = [ProductDTOResponse]

struct ProductDTOResponse: Decodable {
    let id: String?
    let name: String?
    let brand: String?
    let price: Int?
    let discountPrice: Int?
    let discountRate: Int?
    let image: String?
    let link: String?
    let tags: [String]?
    let benefits: [String]?
    let rating: Double?
    let reviewCount: Int?

}
