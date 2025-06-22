//
//  ProductListReposiotury.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation
import Combine
import LogMacro

@Observable
final class ProductListReposiotury: ProductListRepositoryProtocol {
  public func fetchProducts() async throws -> ProductModel? {
    await #logDebug("[ProductRepository] fetchProducts() 호출됨")

    // 1) JSON 배열 디코딩
    let resource = "products"
    let ext = "json"
    await #logDebug("[ProductRepository] 리소스 로드 시도: \(resource).\(ext)")
    guard let url = Bundle.main.url(forResource: resource, withExtension: ext) else {
      await #logError("[ProductRepository] products.json 파일을 찾을 수 없음")
      return nil
    }
    let data = try Data(contentsOf: url)
    await #logDebug("[ProductRepository] 데이터 읽기 성공 (크기: \(data.count) bytes)")

    // 2) 배열 디코딩
    let dtoList: ProductDTOModel
    do {
      dtoList = try JSONDecoder().decode(ProductDTOModel.self, from: data)
      await #logDebug("[ProductRepository] DTO 배열 디코딩 성공: 총 \(dtoList.count)개")
    } catch {
      await #logError("[ProductRepository] DTO 배열 디코딩 실패: \(error.localizedDescription)")
      throw error
    }

    // 3) 중복 제거 & 도메인 변환
    // - dtoList.toDomain() 내부에서 중복 제거 후 ProductModel 생성
    let uniqueDTOs = Array(Dictionary(grouping: dtoList, by: \.id).values.compactMap { $0.first })
    await #logDebug("[ProductRepository] 중복 제거 후 DTO 개수: \(uniqueDTOs.count)")

    let model = uniqueDTOs.toDomain()
    await #logInfo("[ProductRepository] 도메인 모델 변환 완료: 상품 개수= \(model.data.count)")

    return model
  }
}
