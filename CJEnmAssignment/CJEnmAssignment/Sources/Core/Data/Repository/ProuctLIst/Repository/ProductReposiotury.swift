//
//  ProductReposiotury.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation
import Combine
import LogMacro

@Observable
final class ProductReposiotury: ProductListRepositoryProtocol {
  public func fetchProducts() async throws -> ProductModel? {
    // 진입 로그
    await #logDebug("[ProductRepository] fetchProducts() 호출됨")

    // 1) 리소스 로드
    let resource = "products"
    let ext = "json"
    await #logDebug("[ProductRepository] 리소스 로드 시도: \(resource).\(ext)")
    guard let url = Bundle.main.url(forResource: resource, withExtension: ext) else {
      await #logError("[ProductRepository] products.json 파일을 찾을 수 없음")
      return nil
    }
    await #logDebug("[ProductRepository] products.json 경로: \(url.path)")

    // 2) 데이터 읽기
    let data: Data
    do {
      data = try Data(contentsOf: url)
      await #logDebug("[ProductRepository] 데이터 읽기 성공 (크기: \(data.count) bytes)")
    } catch {
      await #logError("[ProductRepository] 데이터 읽기 실패: \(error.localizedDescription)")
      throw error
    }

    // 3) DTO 디코딩
    let dto: ProductDTOModel
    do {
      dto = try JSONDecoder().decode(ProductDTOModel.self, from: data)
      await #logDebug("[ProductRepository] DTO 배열 디코딩 성공: 총 \(dto.count)개")
    } catch {
      await #logError("[ProductRepository] DTO 디코딩 실패: \(error.localizedDescription)")
      throw error
    }

    // 4) 도메인 모델 변환
    let model = dto.toDomain()
    await #logInfo("[ProductRepository] 도메인 모델 변환 완료: 상품 개수=\(model.data.count)")

    
    return model
  }
}
