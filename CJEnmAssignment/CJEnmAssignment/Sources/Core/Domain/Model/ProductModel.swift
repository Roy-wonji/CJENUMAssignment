//
//  ProductModel.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation

struct ProductModel: Decodable, Equatable {
  let data: [ProductResponseModel]
}

struct ProductResponseModel: Decodable, Equatable {
  let id: String
  let name: String
  let brand: String
  let price: Int
  let discountPrice: Int
  let discountRate: Int
  let image: String
  let link: String
  let tags: [String]
  let benefits: [String]
  let rating: Double
  let reviewCount: Int
}
