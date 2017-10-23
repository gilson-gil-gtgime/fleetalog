//
//  RealmHelper.swift
//  Fleetalog
//
//  Created by Gilson Gil on 06/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmHelper {
  static func persist(feedItems: [FeedItem]) {
    let realm = try? Realm()
    realm?.beginWrite()
    for item in feedItems {
      if realm?.object(ofType: FeedItem.self, forPrimaryKey: item.id) == nil {
        realm?.add(item)
      }
    }
    try? realm?.commitWrite()
  }

  static func persistedItems(for type: FeedType) -> [FeedItem] {
    let realm = try? Realm()
    let items = realm?.objects(FeedItem.self).filter("kind == %@", type.kind)
    return items?.flatMap { $0 } ?? []
  }

  static func favourite(feedItem: FeedItem) {
    feedItem.realm?.beginWrite()
    let item = feedItem.realm?.object(ofType: FeedItem.self, forPrimaryKey: feedItem.id)
    item?.favourited = true
    try? feedItem.realm?.commitWrite()
  }

  static func unfavourite(feedItem: FeedItem) {
    feedItem.realm?.beginWrite()
    let item = feedItem.realm?.object(ofType: FeedItem.self, forPrimaryKey: feedItem.id)
    item?.favourited = false
    try? feedItem.realm?.commitWrite()
  }
}
