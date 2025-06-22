//
//  ProducetList.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import SwiftUI

struct ProductListView: View {
  @EnvironmentObject private var coordinator: AppCoordinator
  private var viewModel = ProductListViewModel()
  /// 현재까지 표시할 아이템 수 (페이징 단위: 20개)


  var body: some View {
    ZStack {
      if viewModel.isLoading {
        loadingView()
      } else {
        productListView()

      }
    }
    .onAppear {
      viewModel.send(.onAppear)
      UIScrollView.appearance().bounces = false
    }
  }

  /// 더 표시할 아이템 수를 증가시킵니다.
  private func loadMore(total: Int) {
    let newCount = min(viewModel.displayedCount + viewModel.pageSize, total)
    guard newCount > viewModel.displayedCount else { return }
    viewModel.displayedCount = newCount
  }
}

extension ProductListView {

  @ViewBuilder
  func loadingView() -> some View {
    VStack {
      Spacer()

      ProgressView()
        .progressViewStyle(.circular)
        .tint(.blue)
      Spacer()
    }

  }

  @ViewBuilder
  func productListView() -> some View {
    VStack {
      ScrollView {
        VStack(spacing: 16) {
          // 전체 데이터 중 displayedCount만큼 표시
          let items = viewModel.products?.data ?? []
          ForEach(items.prefix(viewModel.displayedCount), id: \.id) { product in
            ProductRowView(product: product)
              .transition(.move(edge: .bottom).combined(with: .opacity))
              .animation(.spring(), value: viewModel.displayedCount)
            // 마지막 셀이 화면에 나타나면 추가 로드
              .onAppear {
                if product.id == items.prefix(viewModel.displayedCount).last?.id {
                  loadMore(total: items.count)
                }
              }
              .accessibilityIdentifier("ProductRow_\(index)")
              .onTapGesture {
                coordinator.showDetailProductList(url: product.link)
              }
          }
          if viewModel.isLoading {
            ProgressView()
              .padding()
          }
        }
      }
      .scrollIndicators(.hidden)
    }
  }
}
