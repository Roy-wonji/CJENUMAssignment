//
//  AppCoordinator.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation
import Combine
import SwiftUI

/// 앱의 화면 전환 로직을 담당하는 Coordinator.
/// `NavigationStack`의 `path`를 직접 관리하여 뷰 간 네비게이션을 수행합니다.
@Observable
final class AppCoordinator: ObservableObject {

  /// 현재 네비게이션 스택 경로
  var path = NavigationPath()

  // MARK: - Public Methods

  /// 메인 상품 리스트 화면으로 이동합니다.
  ///
  /// 이 메서드를 호출하면 `AppRoute.mainProductList`가
  /// 네비게이션 스택에 추가되어 해당 뷰가 푸시 됩니다.
  func showMainView() {
    path.append(AppRoute.mainProfuctList)
  }


  // MARK: - 초기 진입 설정

    /// Coordinator를 시작합니다.
    /// 기존 스택을 초기화하고, 메인 상품 리스트 화면을 루트로 설정합니다.
    func start() {
      reset()
      showMainView()
    }


  /// 상세 상품 웹뷰 화면으로 이동합니다.
  ///
  /// - Parameter url: 로드할 웹페이지의 URL 문자열
  /// 이 메서드를 호출하면 `AppRoute.detailWebView(url:)`가
  /// 네비게이션 스택에 추가되어 웹뷰가 푸시 됩니다.
  func showDetailProductList(url: String) {
    path.append(AppRoute.deatilWebView(url: url))
  }

  /// 현재 화면을 스택에서 팝(뒤로 가기)합니다.
  ///
  /// 스택에 하나 이상의 경로가 있을 경우, 마지막으로 푸시된 화면을 제거합니다.
  func goBack() {
    guard !path.isEmpty else { return }
    path.removeLast()
  }

  /// 네비게이션 스택을 초기 상태(루트)로 리셋합니다.
  ///
  /// 스택에 쌓여 있는 모든 경로를 제거하여, 첫 화면으로 돌아갑니다.
  func reset() {
    path.removeLast(path.count)
  }
}
