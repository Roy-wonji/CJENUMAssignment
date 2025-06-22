//
//  Extension+ProductDTO.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//


import Foundation

// MARK: - 도메인 변환 확장
extension ProductDTOModel {
  /// DTO를 도메인 `ProductModel`로 변환합니다.
  /// - Returns: `ProductModel` 인스턴스
   func toDomain() -> ProductModel {
    // 1) ProductResponseModel 인스턴스 생성
    let response = self.compactMap{ item in
      return ProductResponseModel(
        id: item.id ?? "",
        name: item.name ?? "",
        brand: item.brand ?? "",
        price: item.price ?? .zero,
        discountPrice: item.discountPrice ?? .zero,
        discountRate: item.discountRate ?? .zero,
        image: item.image ?? "",
        link: item.link ?? "",
        tags: item.tags ?? [],
        benefits: item.benefits ?? [],
        rating: item.rating ?? .zero,
        reviewCount: item.reviewCount ?? .zero
      )
    }

    // 2) 상품 모델 초기화 (배열 타입 매개변수로 선언된 경우 배열로 전달)
    return ProductModel(data: response)
  }
}
