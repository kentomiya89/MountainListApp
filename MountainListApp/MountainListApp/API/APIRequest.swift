//
//  APIRequest.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get
}

enum APIError: Error {
    case network
    case server
    case invalidJSON
}

protocol APIRequest {
    associatedtype Response: Decodable
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParam: [URLQueryItem] { get }

    func configRequest() -> URLRequest
}

extension APIRequest {

    var baseURL: URL {
        return URL(string: "https://s3-ap-northeast-1.amazonaws.com/file.yamap.co.jp/")!
    }

    var queryParam: [URLQueryItem] {
        return []
    }

    func configRequest() -> URLRequest {
        let pathURL = baseURL.appendingPathComponent(path)
        var urlComponent = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)
        urlComponent?.queryItems = queryParam
        let requestURL = urlComponent?.url

        var request = URLRequest(url: requestURL!)
        request.httpMethod = method.rawValue
        return request
    }
}
