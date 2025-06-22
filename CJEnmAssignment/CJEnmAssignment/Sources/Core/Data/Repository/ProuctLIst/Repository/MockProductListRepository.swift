//
//  MockProductListRepository.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation
import Combine

final class MockProductListRepository: ProductListRepositoryProtocol {

  func fetchProducts() async throws -> ProductModel? {
    return nil
  }
}
