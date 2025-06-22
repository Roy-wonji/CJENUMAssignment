//
//  Extension+UseCaseModuleFactory..swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation

import Foundation
import DiContainer


extension UseCaseModuleFactory {
  var useCaseDefinitions: [() -> Module] {
    return [
      registerModule.productListUseCase
    ]
  }
}
