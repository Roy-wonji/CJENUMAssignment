//
//  CJEnmAssignmentApp.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import SwiftUI

@main
struct CJEnmAssignmentApp: App {
  @StateObject private var coordinator = AppCoordinator()
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  var repository  = ProductReposiotury()

    var body: some Scene {
        WindowGroup {
          AppView()
            .environmentObject(coordinator)
            .onAppear {
              Task {
                try? await repository.fetchProducts()
              }
            }
        }
    }
}
