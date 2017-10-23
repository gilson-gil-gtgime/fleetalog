//
//  FeedViewModel.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Foundation
import Alamofire

struct FeedViewModel {
  let feedType: FeedType
  let feedItems: [FeedItem]

  init(feedType: FeedType, feedItems: [FeedItem] = []) {
    self.feedType = feedType
    self.feedItems = feedItems
  }

  func fetch(completion: @escaping CompletionHandlerType<FeedViewModel>) {
    FeedURLRequestable(feedType: feedType).request { callback in
      do {
        guard let results = try callback() as? [FeedItem] else {
          return
        }
        RealmHelper.persist(feedItems: results)
        let viewModel = FeedViewModel(feedType: self.feedType, feedItems: results)
        completion { return viewModel }
      } catch let error as NetworkError {
        let persistedItems = RealmHelper.persistedItems(for: self.feedType)
        if persistedItems.count > 0 {
          let viewModel = FeedViewModel(feedType: self.feedType, feedItems: persistedItems)
          completion { return viewModel }
        } else {
          completion { throw error }
        }
      } catch {
        completion { throw error }
      }
    }
  }

  func actionName(at row: Int) -> String {
    return feedItems[row].favourited ? "unfavourite" : "favourite"
  }

  func commitAction(for row: Int) {
    let item = feedItems[row]
    if item.favourited {
      RealmHelper.unfavourite(feedItem: item)
    } else {
      RealmHelper.favourite(feedItem: item)
    }
  }
}
