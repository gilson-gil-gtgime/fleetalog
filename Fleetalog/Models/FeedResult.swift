//
//  FeedResult.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Foundation
import Mapper

struct FeedResult: Mappable {
  let results: [FeedItem]

  init(map: Mapper) throws {
    results = try map.from("feed.results")
  }
}
