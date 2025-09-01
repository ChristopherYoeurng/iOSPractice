//
//  BookListViewModel.swift
//  BookBrowse
//
//  Created by Christopher Yoeurng on 8/23/25.
//

import Foundation
import SwiftUI

@MainActor
final class BookListViewModel: ObservableObject {
    @Published private(set) var books: [Book] = []
    @Published var searchText: String = ""
    @Published private(set) var isLoading = false
    @Published var errorMessage: String? = nil

    // Persist favorites as a set of book IDs.
    @AppStorage("favoriteIDs") private var favoriteIDsRaw: String = "" {
        didSet { favoriteIDs = Set(favoriteIDsRaw.split(separator: ",").map(String.init)) }
    }
    private(set) var favoriteIDs: Set<String> = []

    var filteredBooks: [Book] {
        guard !searchText.isEmpty else { return books }
        let q = searchText.lowercased()
        return books.filter { $0.title.lowercased().contains(q) || $0.author.lowercased().contains(q) }
    }

    init() {
        // hydrate favorites
        favoriteIDs = Set(favoriteIDsRaw.split(separator: ",").map(String.init))
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        do {
            let result = try await BookAPI.fetchBooks()
            books = result
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Unknown error"
        }
    }

    func isFavorite(_ book: Book) -> Bool { favoriteIDs.contains(book.id) }

    func toggleFavorite(_ book: Book) {
        var set = favoriteIDs
        if set.contains(book.id) { set.remove(book.id) } else { set.insert(book.id) }
        favoriteIDs = set
        favoriteIDsRaw = set.joined(separator: ",")
        objectWillChange.send() // ensure UI updates for list cells
    }
}
