//
//  CodeValidationViewModel.swift
//  iVote
//
//  Created by Hasan Sa on 06/10/2018.
//  Copyright © 2018 Hasan Sa. All rights reserved.
//

import Foundation

protocol CodeValidationViewModelViewDelegate: AnyObject {
  func pinCode() -> String
}

protocol CodeValidationViewModelCoordinatorDelegate: AnyObject {
  func codeValidationViewModelDidEnterCode(viewModel: CodeValidationViewModel)
}


class CodeValidationViewModel {
  weak var viewDelegate: CodeValidationViewModelViewDelegate?
  var coordinatorDelegate: CodeValidationViewModelCoordinatorDelegate?

  // Name and Password and Phone
  var code: String? {
    didSet {
      print(code ?? "")
    }
  }

  init() {
    ElectionsService.shared.getCode() { self.code = $0 }
  }

  // Submit
  func submit() {

    guard let requestCode = self.code else {
      print("request code failed")
      return
    }
    if requestCode == self.viewDelegate?.pinCode() {
      DispatchQueue.main.async {
        self.coordinatorDelegate?.codeValidationViewModelDidEnterCode(viewModel: self)
      }
    }
  }
}
