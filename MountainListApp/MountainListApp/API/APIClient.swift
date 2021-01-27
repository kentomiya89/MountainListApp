//
//  APIClient.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import Foundation
import Alamofire

protocol APIClientSessionable {
    func request<Request: APIRequest>(_ request: Request, completion: @escaping(Result<Request.Response, APIError>) -> Void)
}

final class APIClient: APIClientSessionable {
    func request<Request>(_ request: Request, completion: @escaping (Result<Request.Response, APIError>) -> Void) where Request: APIRequest {

        AF.request(request.configRequest()).responseJSON { response in
            guard let data = response.data else {
                completion(.failure(response.response?.statusCode == nil ? .network : .server))
                return
            }
            do {
                let decodeData = try JSONDecoder().decode(Request.Response.self, from: data)
                completion(.success(decodeData))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.invalidJSON))
            }
        }
    }
}
