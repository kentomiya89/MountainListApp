//
//  MountainInfo.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import Foundation

struct MountainInfo: Decodable {

    let areaId: Int
    let description: String
    let difficultyLevel: Int
    let elevation: Float
    // swiftlint:disable identifier_name
    let id: Int
    let imageUrl: String
    var isLike: Bool
    let latitude: Float
    var likeCount: Int
    let longitude: Float
    let name: String
    let physicalLevel: Int
    let prefectures: [String]
    let thumbnailUrl: String

    enum CodingKeys: String, CodingKey {
        case areaId = "area_id"
        case description
        case difficultyLevel = "difficulty_level"
        case elevation
        // swiftlint:disable identifier_name
        case id
        case imageUrl = "image_url"
        case isLike = "is_like"
        case latitude = "latitude"
        case likeCount = "like_count"
        case longitude = "longitude"
        case name
        case physicalLevel = "physical_level"
        case prefectures = "prefectures"
        case thumbnailUrl = "thumbnail_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        areaId = try values.decode(Int.self, forKey: .areaId)
        description = try values.decode(String.self, forKey: .description)
        difficultyLevel = try values.decode(Int.self, forKey: .difficultyLevel)
        elevation = try values.decode(Float.self, forKey: .elevation)
        id = try values.decode(Int.self, forKey: .id)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        isLike = try values.decode(String.self, forKey: .isLike).toBool ?? false // 適切な値がなければfalse設定
        latitude = try values.decode(Float.self, forKey: .latitude)
        likeCount = try values.decode(Int.self, forKey: .likeCount)
        longitude = try values.decode(Float.self, forKey: .longitude)
        name = try values.decode(String.self, forKey: .name)
        physicalLevel = try values.decode(Int.self, forKey: .physicalLevel)
        prefectures = try values.decode([String].self, forKey: .prefectures)
        thumbnailUrl = try values.decode(String.self, forKey: .thumbnailUrl)
    }
}

extension MountainInfo: Equatable {

    static func == (left: MountainInfo, right: MountainInfo) -> Bool {
        return left.id == right.id
    }
}
