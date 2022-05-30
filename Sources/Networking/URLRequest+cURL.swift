//
//  URLRequest+cURL.swift
//
//
//  Created by Ivan Jovanović on 01/04/2022.
//

import Foundation

extension URLRequest {

    /// Returns the cURL command representation of the URL request.
    public var cURL: String {
        // Logging URL requests in whole may expose sensitive data,
        // or open up possibility for getting access to your user data,
        // so make sure to disable this feature for production builds!
        #if !DEBUG
            return ""
        #else
            let base = "cURL -k \\"
            var method = ""
            var headers = ""
            var body = ""
            var reqURL = ""

            if let httpMethod = httpMethod {
                method = "-X \(httpMethod) \\"
            }

            if let httpHeaders = allHTTPHeaderFields {
                for (header, value) in httpHeaders {
                    headers += "-H \"\(header): \(value)\" \\\n"
                }
            }

            if let httpBody = httpBody,
                let string = String(data: httpBody, encoding: .utf8),
                !httpBody.isEmpty,
                !string.isEmpty
            {
                body += "-d '\(string)'"
            }

            if let url = url {
                reqURL = url.absoluteString
            }

            return """
                \(base)
                \(method)
                \(headers)\(body)
                \(reqURL)
                """
        #endif
    }
}
