//
//  APIManager.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 21/07/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation

// MARK: - API Manager

/// A singleton class responsible for executing HTTP requests.
final class APIManager {

    // MARK: - Properties

    /// Shared instance of `APIManager`.
    static let shared = APIManager()

    // MARK: - Initializer

    /// Prevents creating multiple instances.
    private init() {}

    // MARK: - Public Methods

    /// Executes a network request and decodes the response.
    ///
    /// - Parameters:
    ///   - request: Complete URL string.
    ///   - httpParameter: Request body parameters for POST/PUT requests.
    ///   - httpMethod: HTTP request method.
    ///   - httpHeaderFields: HTTP header fields.
    ///   - type: Expected response model.
    ///   - completion: Returns decoded object or an error.
    func execute<T: Codable>(
        _ request: String,
        httpParameter params: [String: Any]? = nil,
        httpMethod method: HTTPMethod = .get,
        httpHeaderFields headers: [String: String]? = nil,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {

        // Validate URL
        guard let url = URL(string: request) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        // Create URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 30

        // Add custom headers
        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers
        }

        // Encode body parameters for non-GET requests
        if method != .get,
           let params = params {

            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)

                // Add default content type if missing
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    urlRequest.setValue(
                        "application/json",
                        forHTTPHeaderField: "Content-Type"
                    )
                }

            } catch {
                completion(.failure(error))
                return
            }
        }

        // Execute request
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            // Network error
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            // Validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }

            // Validate status code
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(
                        .failure(
                            NSError(
                                domain: "API Error",
                                code: httpResponse.statusCode,
                                userInfo: [
                                    NSLocalizedDescriptionKey:
                                        HTTPURLResponse.localizedString(
                                            forStatusCode: httpResponse.statusCode
                                        )
                                ]
                            )
                        )
                    )
                }
                return
            }

            // Ensure response contains data
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.zeroByteResource)))
                }
                return
            }

            do {
                // Decode response
                let object = try JSONDecoder().decode(T.self, from: data)
                print(String(data: data, encoding: .utf8) ?? "")
                DispatchQueue.main.async {
                    completion(.success(object))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }

        }.resume()
    }
}

// MARK: - API Endpoints

/// API endpoints used throughout the application.
enum SERequest: String {

    case posts = "posts"
    case character = "character"

    /// Complete endpoint URL.
    var getURL: String {
//        "https://jsonplaceholder.typicode.com/\(rawValue)"
        "https://rickandmortyapi.com/api/\(rawValue)"
    }
}

// MARK: - HTTP Method

/// Supported HTTP methods.
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
