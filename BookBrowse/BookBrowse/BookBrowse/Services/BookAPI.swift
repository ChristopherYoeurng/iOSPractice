//
//  BookAPI.swift
//  BookBrowse
//
//  Created by Christopher Yoeurng on 8/23/25.
//

import Foundation

enum BookAPIError: Error, LocalizedError {
    case badData
    case simulatedNetwork
    var errorDescription: String? {
        switch self {
        case .badData: return "Invalid data."
        case .simulatedNetwork: return "Network error. Please try again."
        }
    }
}

struct BookAPI {
    // Simulates async fetch with occasional error
    static func fetchBooks() async throws -> [Book] {
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5s latency
        if Bool.random() { throw BookAPIError.simulatedNetwork }
        guard let url = Bundle.main.url(forResource: "MockData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let books = try? JSONDecoder().decode([Book].self, from: data) else {
            throw BookAPIError.badData
        }
        return books
    }
}
