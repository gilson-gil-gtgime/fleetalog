//
//  FeedType.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Foundation

enum FeedType {
  case music, movies

  var kind: String {
    switch self {
    case .music:
      return "song"
    case .movies:
      return "movie"
    }
  }
}
