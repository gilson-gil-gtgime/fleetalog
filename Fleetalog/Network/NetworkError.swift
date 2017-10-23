//
//  NetworkError.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  case timeout
  case noConnection

  init?(error: Error?) {
    if let error = error {
      switch error._code {
      case NSURLErrorTimedOut:
        self = .timeout
        return
      case NSURLErrorNotConnectedToInternet:
        self = .noConnection
        return
      default:
        break
      }
    }
    return nil
  }
}
