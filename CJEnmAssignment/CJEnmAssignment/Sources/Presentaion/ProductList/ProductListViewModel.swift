//
//  ProductListViewModel.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Combine
import SwiftUI
import LogMacro

@MainActor
@Observable
final class ProductListViewModel {
  // MARK: - State (synthesized via @Observable)
  /// 상품 목록 모델
  var products: ProductModel? = nil
  /// 로딩 상태
  var isLoading: Bool = false
  /// 에러 메시지
  var errorMessage: String? = nil

  // MARK: - Dependencies
  private let repository: ProductListRepositoryProtocol
  private let useCase: ProductListUseCase

  // MARK: - Initialization
  /// 의존성 주입 생성자
  public init(repository: ProductListRepositoryProtocol = ProductReposiotury()) {
    self.repository = repository
    self.useCase = ProductListUseCase(repository: repository)
  }

  // MARK: - Actions
  public enum Action {
    /// 뷰가 나타날 때
    case onAppear
    /// 상품 조회 시작
    case fetchProducts
    /// 상품 조회 결과 응답
    case productsResponse(Result<ProductModel?, Error>)
  }

  // MARK: - Send
  /// 액션을 받아 상태를 갱신하거나 부수 효과를 수행합니다.
  public func send(_ action: Action) {
    switch action {
    case .onAppear:
      // 뷰 표시 시 바로 상품 조회 액션 트리거
      send(.fetchProducts)

    case .fetchProducts:
      // 로딩 시작
      isLoading = true
      Task {
        let result: Result<ProductModel?, Error>
        do {
          let model = try await useCase.fetchProducts()
          result = .success(model)
        } catch {
          result = .failure(error)
        }
        // 메인 스레드에서 응답 처리
        await MainActor.run { send(.productsResponse(result)) }
      }

    case .productsResponse(let result):
      // 로딩 종료
      isLoading = false
      switch result {
      case .success(let model):
        products = model
        errorMessage = nil
      case .failure(let error):
        errorMessage = error.localizedDescription
        #logError("Product fetch failed: \(error.localizedDescription)")
      }
    }
  }
}
