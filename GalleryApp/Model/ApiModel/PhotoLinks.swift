// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcomeLinks = try? newJSONDecoder().decode(WelcomeLinks.self, from: jsonData)

import Foundation

// MARK: - WelcomeLinks
struct PhotoLinks: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}
