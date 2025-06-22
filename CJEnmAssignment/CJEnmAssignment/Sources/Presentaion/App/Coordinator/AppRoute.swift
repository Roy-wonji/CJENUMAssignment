//
//  AppRoute.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation

/// 앱의 네비게이션 경로를 정의하는 열거형.
/// `AppCoordinator`의 `path`에 사용되는 라우트 케이스를 제공합니다.
enum AppRoute: Hashable {

  /// 메인 상품 리스트 화면으로 이동하는 라우트
  case mainProfuctList

  /// 상세 상품 웹뷰 화면으로 이동하는 라우트
  ///
  /// - Parameter url: 로드할 웹페이지의 URL 문자열
  case deatilWebView(url: String)
}
