//
//  ProductListUseCaseProtocol.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation

protocol ProductListUseCaseProtocol {
  func fetchProducts()  async throws -> ProductModel?
}
