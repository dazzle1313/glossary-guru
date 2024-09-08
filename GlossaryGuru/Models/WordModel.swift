import Foundation

struct Words: Codable {
    let id: Int
    let word: String
    let translation: String
    let transcription: String
    let page: Int
    let definition: String
}
