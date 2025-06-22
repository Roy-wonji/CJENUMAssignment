//
//  CJEnmAssignmentTests.swift
//  CJEnmAssignmentTests
//
//  Created by Wonji Suh  on 6/22/25.
//

import Testing
@testable import CJEnmAssignment

// ProductListUseCase 유닛 테스트
struct ProductListUseCaseTests {
  @Test
  func 테스트_상품목록_성공() async throws {
    // given: 성공 목 레포지토리 주입
    let repository = MockProductListRepository()
    let useCase = ProductListUseCase(repository: repository)

    // when: use case 실행
    let result = try await useCase.fetchProducts()

    // then: 결과 검증
      // 2) 옵셔널 String? 을 .equal("…") 으로 검사
    #expect(((result?.data.first?.name) != nil), "모크 상품")


  }
//
  @Test
  func 테스트_상품목록_빈배열() async throws {
    // given: 빈 결과 목 레포지토리 주입
    let repository = MockProductListRepositoryEmpty()
    let useCase = ProductListUseCase(repository: repository)

    // when
    let result = try await useCase.fetchProducts()

    // then: data 배열이 비어 있어야 함
    #expect(result?.data.isEmpty ?? false)
  }
}
