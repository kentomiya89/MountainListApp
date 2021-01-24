//
//  YAMAPAPI.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import Foundation

final class YAMAPAPI {

    struct MoutainsList: APIRequest {
        typealias Response = [MountainInfo]

        var path: String {
            return "ios/mountains.json"
        }

        var method: HTTPMethod {
            return .get
        }
    }
}
