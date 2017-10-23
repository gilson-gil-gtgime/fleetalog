//
//  Endpoints.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Foundation

struct Endpoints {
  static let baseURLString = "https://rss.itunes.apple.com/api/v1/br/"
  static let baseURL = URL(string: Endpoints.baseURLString)

  static let music = "itunes-music/hot-tracks/all/100/explicit.json"
  static let movies = "movies/top-movies/all/100/explicit.json"
}
