//
//  WebViews.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/23/25.
//

import SwiftUI

struct WebViews: View {
  @EnvironmentObject var coordinator: AppCoordinator
  var url: String


  init(url: String) {
    self.url = url
  }


  var body: some View {
    VStack {
      Spacer()
        .frame(height: 14)

      NavigationBackButton{
        coordinator.goBack()
      }

      WebView(urlToLoad: url)
    }
  }
}
