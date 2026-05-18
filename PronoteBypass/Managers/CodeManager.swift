import Foundation

struct CodeEntry: Codable {
    let code: String
    let timestamp: Date
}

final class CodeManager: @unchecked Sendable {
    static let shared = CodeManager()
    private let key = "capturedCodes"

    private init() {}

    func save(_ code: String) {
        var entries = loadAll()
        entries.append(CodeEntry(code: code, timestamp: Date()))
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func loadAll() -> [CodeEntry] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let entries = try? JSONDecoder().decode([CodeEntry].self, from: data)
        else { return [] }
        return entries
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
