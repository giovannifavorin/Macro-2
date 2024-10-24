import Foundation

struct SaintDescription: Identifiable {
    var id: UUID
    var title: String?
    var content: String
}

struct Saints: Identifiable {
    var id: UUID
    var day: String
    var month: UIImage
    var name: String
    var description: [SaintDescription]
}
