//
//  WebView.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import SwiftUI
import WebKit

/// WKWebView와 로딩 인디케이터를 포함한 UIViewRepresentable 래퍼입니다.
/// 지정된 URL 문자열을 비동기 로드하며, 로딩 중에는 스피너를 표시합니다.
public struct WebView: UIViewRepresentable {
  // MARK: - 속성

  /// 로드할 웹페이지의 URL 문자열
  private var urlToLoad: String

  // MARK: - 초기화

  /// WebView를 생성합니다.
  /// - Parameter urlToLoad: 로드할 URL 문자열
  public init(urlToLoad: String) {
    self.urlToLoad = urlToLoad
  }

  // MARK: - UIViewRepresentable 프로토콜 구현

  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  public func makeUIView(context: Context) -> UIView {
    let containerView = UIView()
    containerView.backgroundColor = .white

    let configuration = WKWebViewConfiguration()
    let webView = WKWebView(frame: .zero, configuration: configuration)
    webView.scrollView.showsVerticalScrollIndicator = false
    webView.allowsLinkPreview = true
    webView.backgroundColor = .white
    webView.translatesAutoresizingMaskIntoConstraints = false

    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.color = .blue
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.hidesWhenStopped = true

    containerView.addSubview(webView)
    containerView.addSubview(spinner)
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: containerView.topAnchor),
      webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      webView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
    ])

    context.coordinator.webView = webView
    context.coordinator.spinner = spinner

    // async/await로 로드 처리
    Task {
      await context.coordinator.loadURLAsync(urlString: urlToLoad)
    }

    return containerView
  }

  public func updateUIView(_ uiView: UIView, context: Context) {
    // 동적 업데이트 필요 시 구현
  }

  // MARK: - Coordinator

  /// WKWebView 로딩을 async/await로 처리하는 코디네이터 클래스
  public class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
    var parent: WebView
    weak var webView: WKWebView?
    weak var spinner: UIActivityIndicatorView?

    // 내비게이션 완료 대기를 위한 Continuation
    private var navigationContinuation: CheckedContinuation<Void, Error>?

    init(_ parent: WebView) {
      self.parent = parent
    }

    /// URL을 비동기로 로드하고, 로딩 완료까지 대기합니다.
    /// - Parameter urlString: 로드할 URL 문자열
    func loadURLAsync(urlString: String) async {
      guard let webView = webView,
            let url = URL(string: urlString) else { return }
      let request = URLRequest(url: url)

      // 스피너 표시
      await MainActor.run { spinner?.startAnimating() }

      // Delegate 설정
      webView.navigationDelegate = self

      // 요청 시작
      _ = webView.load(request)

      // 완료 대기
      do {
        try await waitForNavigation()
      } catch {
        // 에러 처리 필요 시 추가
      }

      // 스피너 숨기기
      await MainActor.run { spinner?.stopAnimating() }
    }

    /// navigationDelegate 콜백을 Continuation으로 연결합니다.
    private func waitForNavigation() async throws {
      try await withCheckedThrowingContinuation { continuation in
        navigationContinuation = continuation
      }
    }

    // MARK: - WKNavigationDelegate

    public func webView(_ webView: WKWebView,
                        didFinish navigation: WKNavigation!) {
      navigationContinuation?.resume(returning: ())
      navigationContinuation = nil
    }

    public func webView(_ webView: WKWebView,
                        didFail navigation: WKNavigation!,
                        withError error: Error) {
      navigationContinuation?.resume(throwing: error)
      navigationContinuation = nil
    }

    public func webView(_ webView: WKWebView,
                        didFailProvisionalNavigation navigation: WKNavigation!,
                        withError error: Error) {
      navigationContinuation?.resume(throwing: error)
      navigationContinuation = nil
    }
  }
}
