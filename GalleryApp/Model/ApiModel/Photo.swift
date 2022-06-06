import Foundation

// MARK: - WelcomeElement
struct Photo: Codable, Identifiable, Equatable {
    let id: String
//    let createdAt, updatedAt: Date
//    let width, height: Int
//    let color, blurHash: String
//    let likes: Int
//    let likedByUser: Bool
//    let welcomeDescription: String
//    let user: User
//    let currentUserCollections: [CurrentUserCollection]
    let urls: Urls
//    let links: PhotoLinks

    enum CodingKeys: String, CodingKey {
        case id
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case width, height, color
//        case blurHash = "blur_hash"
//        case likes
//        case likedByUser = "liked_by_user"
//        case welcomeDescription = "description"
//        case user
//        case currentUserCollections = "current_user_collections"
        case urls
//        case links
    }
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}
