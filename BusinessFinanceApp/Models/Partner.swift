import Foundation

struct Partner: Identifiable, Hashable {
    let id: UUID
    let name: String
    let shortName: String
    let status: String
}
