//
//  FeedURLRequestable.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Alamofire

struct FeedURLRequestable: URLRequestable {
  let feedType: FeedType

  var method: HTTPMethod {
    return .get
  }

  var path: String {
    switch feedType {
    case .music:
      return Endpoints.music
    case .movies:
      return Endpoints.movies
    }
  }

  var parameters: Parameters? {
    return nil
  }

  var headers: Parameters? {
    return nil
  }

  var encoding: ParameterEncoding {
    return URLEncoding.queryString
  }

  func handleResponse(response: DataResponse<Any>, completion: @escaping CompletionHandlerType<Any?>) {
    guard let json = response.result.value as? [String: Any] else {
      return
    }
    guard let feedResult = FeedResult.from(json as NSDictionary) else {
      return
    }
    completion { return feedResult.results }
  }
}
