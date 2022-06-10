//
//  APIRequest.swift
//
//
//  Created by Ivan Jovanović on 31/03/2022.
//

import Foundation

/// Represents the HTTP request with standard HTTP methods (GET, POST, PUT and DELETE).
public struct APIRequest<URLBase>
where
  URLBase: BaseURL,
  URLBase: RawRepresentable,
  URLBase.RawValue == String
{
  private var request: URLRequest
  private let verifyResponse: Bool

  /// Initializes a new APIRequest
  /// - Parameters:
  ///   - url: The url that conforms to `BaseURL` protocol.
  ///   - queryItems: The query items which will be added after the `url` param.
  ///   - params: The params which will replace placeholders in url (e.g. {id}...).
  ///   - method: The HTTP method.
  ///   - verifyResponse: The value indicating whether the answer should be verified or not.
  public init(
    _ url: URLBase,
    queryItems: [String: String] = [:],
    params: [String: String] = [:],
    method: HttpMethod,
    verifyResponse: Bool = true
  ) throws {
    let requestURL = Query.parseParams(url.fullURL, params: params).urlEncoded

    guard var urlComponents = URLComponents(string: requestURL) else {
      throw NetworkError.invalidURL(url: requestURL)
    }
    urlComponents.queryItems = Query.toQueryItems(queryItems)

    guard let urlRequest = urlComponents.url else {
      throw NetworkError.invalidURL(url: urlComponents.url?.description ?? url.fullURL)
    }

    request = URLRequest(url: urlRequest)
    request.httpMethod = method.name
    self.verifyResponse = verifyResponse
    APIHeaders.addHeadersToRequest(&request)
  }
}

extension APIRequest {
  /// Adds body to the HTTP method.
  ///
  /// - Parameter encodable: The type that conforms to  `Encodable`.
  /// - Returns: The APIRequest with modified body if the HTTP method is not set to GET,
  ///  throws ``NetworkError/notSupported(reason:)`` otherwise.
  public func setBody<E: Encodable>(_ encodable: E) throws -> APIRequest {
    guard request.httpMethod != HttpMethod.get.name else {
      throw NetworkError.notSupported(
        reason: "You should not set body to HTTP GET method."
      )
    }

    var request = self
    request.request.httpBody = try JSON.encoder.encode(encodable)

    return request
  }

  ///  Performs the api request.
  ///
  ///  - Returns: A decoded response.
  public func perform<D: Decodable>() async throws -> D {
    let (data, response) = try await URLSession.shared.data(for: request)

    Networking.logRequest(request: request)

    // Uncomment the following line if you want to see the response
    // Networking.logResponse(response: response, data: data)

    if let error = Response.verify(response: response), verifyResponse {
      throw error
    }

    guard let value = try? JSON.decoder.decode(D.self, from: data) else {
      throw NetworkError.decodingError(D.self)
    }

    return value
  }
}

extension URLSession {
  fileprivate func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    try await withCheckedThrowingContinuation { continuation in
      let task = dataTask(with: request) { data, response, error in
        guard let data = data, let response = response else {
          let error = error ?? URLError(.badServerResponse)
          return continuation.resume(throwing: error)
        }
        continuation.resume(returning: (data, response))
      }
      task.resume()
    }
  }
}
