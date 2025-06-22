//
//  ProducetList.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import SwiftUI

struct ProductListView: View {
  @EnvironmentObject private var coordinator: AppCoordinator
  private var vm = ProductListViewModel()
  /// 현재까지 표시할 아이템 수 (페이징 단위: 20개)
  @State private var displayedCount: Int = 20
  private let pageSize = 20

  var body: some View {
    ScrollView {
      VStack(spacing: 16) {
        // 전체 데이터 중 displayedCount만큼 표시
        let items = vm.products?.data ?? []
        ForEach(items.prefix(displayedCount), id: \.id) { product in
          ProductRowView(product: product)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .animation(.spring(), value: displayedCount)
          // 마지막 셀이 화면에 나타나면 추가 로드
            .onAppear {
              if product.id == items.prefix(displayedCount).last?.id {
                loadMore(total: items.count)
              }
            }
            .onTapGesture {
              coordinator.showDetailProductList(url: product.link)
            }
        }
        if vm.isLoading {
          ProgressView()
            .padding()
        }
      }
    }
    .onAppear {
      vm.send(.onAppear)
    }
  }

  /// 더 표시할 아이템 수를 증가시킵니다.
  private func loadMore(total: Int) {
    let newCount = min(displayedCount + pageSize, total)
    guard newCount > displayedCount else { return }
    displayedCount = newCount
  }
}
