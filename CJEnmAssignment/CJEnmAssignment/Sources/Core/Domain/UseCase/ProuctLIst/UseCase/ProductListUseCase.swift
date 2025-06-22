//
//  ProductListUseCase.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation

import DiContainer

struct ProductListUseCase: ProductListUseCaseProtocol {
  private let repository: ProductListRepositoryProtocol

  init(repository: ProductListRepositoryProtocol) {
    self.repository = repository
  }

  func fetchProducts() async throws -> ProductModel? {
    return try await repository.fetchProducts()
  }
}

extension DependencyContainer {
  var productListUseCase: ProductListRepositoryProtocol? {
    resolve(ProductListRepositoryProtocol.self)
  }
}

public extension RegisterModule {
  var productListUseCase: () -> Module {
    makeUseCaseWithRepository(
      ProductListUseCaseProtocol.self,
      repositoryProtocol: ProductListRepositoryProtocol.self,
      repositoryFallback: MockProductListRepository(),
      factory: { repo in
        ProductListUseCase(repository: repo)
      }
    )
  }

  var productListRepository: () -> Module {
    makeDependency(ProductListRepositoryProtocol.self) {
      ProductReposiotury()
    }
  }
}
