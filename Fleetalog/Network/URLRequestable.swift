//
//  URLRequestable.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Alamofire

protocol URLRequestable: URLRequestConvertible {
  var method: HTTPMethod { get }
  var path: String { get }
  var parameters: Parameters? { get }
  var headers: Parameters? { get }
  var encoding: ParameterEncoding { get }

  func handleResponse(response: DataResponse<Any>, completion: @escaping CompletionHandlerType<Any?>)
}

extension URLRequestable {
  func asURLRequest() throws -> URLRequest {
    guard let url = Endpoints.baseURL?.appendingPathComponent(path) else {
      fatalError("base url or path not valid")
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    headers?.forEach {
      guard let value = $0.value as? String else {
        return
      }
      urlRequest.addValue(value, forHTTPHeaderField: $0.key)
    }
    return try encoding.encode(urlRequest, with: parameters)
  }

  func request(_ completion: @escaping CompletionHandlerType<Any?>) {
    Alamofire.request(self).responseJSON { response in
      if let networkError = NetworkError(error: response.error) {
        completion { throw networkError }
        return
      }
      self.handleResponse(response: response, completion: completion)
    }
  }
}
