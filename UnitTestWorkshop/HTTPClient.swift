//
//  HTTPClient.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 23/01/25.
//

import Foundation

public enum URLEncoding {
    case httpBody
    case queryString
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

struct HttpRequest {
    let method: HTTPMethod
    let endpoint: String
    let parameters: [String: Any]?
    let headers: [String: Any]?
    let encoding: URLEncoding
    
    init(method: HTTPMethod,
         endpoint: String,
         parameters: [String: Any]?,
         headers: [String: Any]?,
         encoding: URLEncoding) {
        self.method = method
        self.endpoint = endpoint
        self.parameters = parameters
        self.headers = headers
        self.encoding = encoding
    }
}

enum HTTPError: Error {
    case badURLFormat
    case requestFailed
    case badStatusCode
    case decodingDataFailed
}

public struct APIClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func get<T: Decodable>(
        endpoint: String,
        parameters: [String: Any]? = nil,
        headers: [String : Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void) {
        let request = HttpRequest(
            method: .get,
            endpoint: endpoint,
            parameters: parameters,
            headers: headers,
            encoding: .queryString
        )
        guard let urlRequest = URLRequest(model: request) else {
            completion(.failure(HTTPError.badURLFormat))
            return
        }
        let urlTask = session.dataTask(with: urlRequest) { data, response, error in
            switch self.filter(data, response, error) {
            case .success(let data):
                guard let data = data, let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(HTTPError.decodingDataFailed))
                    return
                }
                completion(.success(decodedResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        urlTask.resume()
    }
    
    private func filter(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<Data?, HTTPError> {
        guard error == nil else {
            return .failure(HTTPError.requestFailed)
        }
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            return.failure(HTTPError.badStatusCode)
        }

        return .success(data)
    }
}

extension URLRequest {
    init?(model: HttpRequest) {
        var urlComponents = URLComponents(string: model.endpoint)
        if model.encoding == .queryString, let parameters = model.parameters {
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents?.url else { return nil }
        
        self.init(url: url)
        
        self.httpMethod = model.method.rawValue
        model.headers?.forEach {
            self.setValue("\($0.value)", forHTTPHeaderField: $0.key)
        }
        
        if model.encoding == .httpBody, let parameters = model.parameters {
            self.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        }
    }
}
