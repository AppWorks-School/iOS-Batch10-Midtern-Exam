//
//  HTTPClient.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

enum LKHTTPClientError: Error {

    case decodeDataFail

    case clientError(Data)

    case serverError

    case unexpectedError
}

enum LKHTTPMethod: String {

    case get = "GET"

    case post = "POST"
}

enum LKHTTPHeaderField: String {

    case contentType = "Content-Type"

    case auth = "Authorization"
}

enum LKHTTPHeaderValue: String {

    case json = "application/json"
    
    case formData = "application/x-www-form-urlencoded"
}

protocol LKRequest {
    
    var baseURL: String { get }

    var headers: [String: String] { get }

    var body: Data? { get }

    var method: String { get }

    var endPoint: String { get }
    
    var queryString: [String: String] { get }
}

extension LKRequest {
    
    var queryString: [String: String] { return [:] }
    
    func makeRequest() -> URLRequest {
        
        let url = URL(string: baseURL+endPoint+makeQueryPath())!
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        request.httpBody = body
        
        request.httpMethod = method
        
        
        
        return request
    }
    
    func makeQueryPath() -> String {
        
        var result = String.empty
        
        for (key, value) in queryString {
            
            result += key + "=" + value + "&"
        }
        
        return "?" + result
    }
}

class HTTPClient {

    static let shared = HTTPClient()

    private let decoder = JSONDecoder()

    private let encoder = JSONEncoder()

    private init() { }

    func request(
        _ request: LKRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        
        URLSession.shared.dataTask(
            with: request.makeRequest(),
            completionHandler: { (data, response, error) in

            guard error == nil else {

                return completion(Result.failure(error!))
            }
                
            // swiftlint:disable force_cast
            let httpResponse = response as! HTTPURLResponse
            // swiftlint:enable force_cast
            let statusCode = httpResponse.statusCode

            switch statusCode {

            case 200..<300:

                completion(Result.success(data!))

            case 400..<500:

                completion(Result.failure(LKHTTPClientError.clientError(data!)))

            case 500..<600:

                completion(Result.failure(LKHTTPClientError.serverError))

            default: return

                completion(Result.failure(LKHTTPClientError.unexpectedError))
            }

        }).resume()
    }
}
