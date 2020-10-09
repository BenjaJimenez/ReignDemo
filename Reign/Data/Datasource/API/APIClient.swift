//
//  APIClient.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

internal typealias APIClientCompletionHandler = (_ success: Bool, _ response: HTTPURLResponse?, _ json: Data?) -> ()

public class APIClient {
    
    internal let sessionConfiguration = URLSessionConfiguration.ephemeral
    internal let session: URLSession
    
    internal init() {
        sessionConfiguration.urlCache = nil
        // set additonal http headers (eg. app name and version)
        // sessionConfiguration.httpAdditionalHeaders
        sessionConfiguration.httpCookieAcceptPolicy = .always
        sessionConfiguration.timeoutIntervalForResource = 15
        session = URLSession(configuration: sessionConfiguration)
    }
    
    
    
    fileprivate func request(URL: Foundation.URL, method: APIHTTPMethod, contentType: APIHTTPContentType = .json, parameters: APIClientParameters? = nil, headers: [String: String]? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: URL)
        request.httpMethod = method.rawValue
        if let parameters = parameters {
            switch method {
            case .GET:
                guard var URLComponents = URLComponents(url: URL, resolvingAgainstBaseURL: true) else {
                    break
                }
                URLComponents.queryItems = parameters.map {
                    (key, value) in
                    URLQueryItem(name: key, value: value as? String ?? String(describing: value))
                }
                if let actualURL = URLComponents.url {
                    request.url = actualURL
                }
                break
                
            case .POST, .PUT, .DELETE:
                request.setValue(contentType.headerValue(), forHTTPHeaderField: "Content-Type")
                request.httpBody = contentType.HTTPBodyForParameters(parameters)
                break
            }
        }
        if let headers = headers {
            for(field, value) in headers {
                request.addValue(value, forHTTPHeaderField: field)
            }
        }
        
        return request.copy() as! URLRequest
    }
    
    // MARK: - Generic Call Methods
    
    internal func performGenericCall(URL: Foundation.URL, method: APIHTTPMethod, contentType: APIHTTPContentType = .json, parameters: APIClientParameters? = nil, headers: [String: String]? = nil, completionHandler: @escaping APIClientCompletionHandler) {
        let request = self.request(URL: URL, method: method, contentType: contentType, parameters: parameters, headers: headers)
                
        let dataTask = session.dataTask(with: request,
                                        completionHandler: {
                                            (data: Data?, response: URLResponse?, error: Error?) in
                                            let httpResponse = response as? HTTPURLResponse
                                            DispatchQueue.main.async(execute: {
                                                if let data = data, error == nil {
                                                    completionHandler(true, httpResponse, data)
                                                } else {
                                                    NSLog("error: \(String(describing: error))")
                                                    completionHandler(false, httpResponse, nil)
                                                }
                                            })
        })
        dataTask.resume()
    }
}

public typealias APIClientParameters = [String: Any]

public enum APIHTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public enum APIHTTPContentType {
    case json
    case formURLEncoded
    
    func headerValue() -> String {
        switch self {
        case .json: return "application/json"
        case .formURLEncoded: return "application/x-www-form-urlencoded"
        }
    }
    
    func HTTPBodyForParameters(_ parameters: APIClientParameters) -> Data? {
        switch self {
        case .json:
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                return data
            } catch {
                NSLog("JSON serialization error: \(error)")
                return nil
            }
            
        case .formURLEncoded:
            var URLComponents = Foundation.URLComponents()
            URLComponents.queryItems = parameters.map {
                (key, value) in
                URLQueryItem(name: key, value: value as? String ?? String(describing: value))
            }
            //Replaced + with %2B because URLComponents does not encode + symbol.
            let string = URLComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            let data = string?.data(using: String.Encoding.utf8)
            return data
        }
    }
}
