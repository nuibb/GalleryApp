// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currentUserCollection = try? newJSONDecoder().decode(CurrentUserCollection.self, from: jsonData)

import Foundation

// MARK: - CurrentUserCollection
struct CurrentUserCollection: Codable {
    let id: Int
    let title: String
    let publishedAt, lastCollectedAt, updatedAt: Date
    let coverPhoto, user: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, title
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
        case coverPhoto = "cover_photo"
        case user
    }
}
