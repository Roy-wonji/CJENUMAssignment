//
//  AppView.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import SwiftUI

struct AppView: View {
  @EnvironmentObject private var coordinator: AppCoordinator

    var body: some View {
      NavigationStack(path: $coordinator.path) {
        ProductListView()
          .navigationDestination(for: AppRoute.self, destination: makeDestination)
      }

    }

  @ViewBuilder
    private func makeDestination(for route: AppRoute) -> some View {
      switch route {
      case .mainProfuctList:
        ProductListView()
      case .deatilWebView(let url):
        WebViews(url: url)
          .navigationBarBackButtonHidden()
      }
    }
}

#Preview {
    AppView()
}
