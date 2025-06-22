//
//  MockProductListRepository.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation
import Combine

/// 성공 케이스를 위한 목(MOCK) 레포지토리: 단일 상품 반환
 final class MockProductListRepository: ProductListRepositoryProtocol {
  func fetchProducts() async throws -> ProductModel? {
    // 샘플 상품 응답 모델 생성
    let mockItem = ProductResponseModel(
      id: "test123",
      name: "모크 상품",
      brand: "모크브랜드",
      price: 1000,
      discountPrice: 800,
      discountRate: 20,
      image: "https://example.com/image.jpg",
      link: "https://example.com/product",
      tags: ["태그1", "태그2"],
      benefits: ["혜택1"],
      rating: 4.5,
      reviewCount: 10
    )
    // 도메인 모델로 래핑
    let model = ProductModel(data: [mockItem])
    return model
  }
}

/// 빈 결과를 반환하는 목 레포지토리: 상품 없음 시나리오
class MockProductListRepositoryEmpty: ProductListRepositoryProtocol {
  func fetchProducts() async throws -> ProductModel? {
    return ProductModel(data: [])
  }
}
