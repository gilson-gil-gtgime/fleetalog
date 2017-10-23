//
//  Genre.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Foundation
import Mapper
import Realm
import RealmSwift

final class Genre: Object, Mappable {
  @objc dynamic var genreId: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var url: String = ""

  init(map: Mapper) throws {
    genreId = try map.from("genreId")
    name = try map.from("name")
    url = try map.from("url")
    super.init()
  }

  required init(realm: RLMRealm, schema: RLMObjectSchema) {
    super.init(realm: realm, schema: schema)
  }
  
  required init(value: Any, schema: RLMSchema) {
    super.init(value: value, schema: schema)
  }
  
  required init() {
    super.init()
  }
}
