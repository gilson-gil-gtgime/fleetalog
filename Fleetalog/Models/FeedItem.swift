//
//  FeedItem.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Foundation
import Mapper
import Realm
import RealmSwift

final class FeedItem: Object, Mappable {
  @objc dynamic var artistId: String? = nil
  @objc dynamic var artistName: String = ""
  @objc dynamic var artistUrl: String? = nil
  @objc dynamic var artworkUrl100: String = ""
  @objc dynamic var collectionName: String? = nil
  @objc dynamic var copyright: String? = nil
  var genres = List<Genre>()
  @objc dynamic var id: String = ""
  @objc dynamic var kind: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var releaseDate: String = ""
  @objc dynamic var url: String = ""
  @objc dynamic var favourited: Bool = false

  override static func primaryKey() -> String? {
    return "id"
  }

  init(map: Mapper) throws {
    artistId = map.optionalFrom("artistId")
    artistName = try map.from("artistName")
    artistUrl = map.optionalFrom("artistUrl")
    artworkUrl100 = try map.from("artworkUrl100")
    collectionName = map.optionalFrom("collectionName")
    copyright = map.optionalFrom("copyright")
    let genres: [Genre] = try map.from("genres")
    for genre in genres {
      self.genres.append(genre)
    }
    id = try map.from("id")
    kind = try map.from("kind")
    name = try map.from("name")
    releaseDate = try map.from("releaseDate")
    url = try map.from("url")
    super.init()
  }

  required init() {
    super.init()
  }

  required init(realm: RLMRealm, schema: RLMObjectSchema) {
    super.init(realm: realm, schema: schema)
  }

  required init(value: Any, schema: RLMSchema) {
    super.init(value: value, schema: schema)
  }
}
