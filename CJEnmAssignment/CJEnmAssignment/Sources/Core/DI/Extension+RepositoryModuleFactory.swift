//
//  Extension+RepositoryModuleFactory.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import Foundation

import DiContainer

extension RepositoryModuleFactory {
  public mutating func registerDefaultDefinitions() {
    let registerModuleCopy = registerModule  // self

    repositoryDefinitions = {
      return [
        registerModuleCopy.productListRepository
      ]
    }()
  }
}
