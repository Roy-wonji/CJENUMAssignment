//
//  ProductListRepositoryProtocol.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation

protocol ProductListRepositoryProtocol {
  func fetchProducts()  async throws -> ProductModel?
}
