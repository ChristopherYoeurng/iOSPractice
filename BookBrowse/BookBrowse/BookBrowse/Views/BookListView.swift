//
//  BookListView.swift
//  BookBrowse
//
//  Created by Christopher Yoeurng on 8/23/25.
//

import SwiftUI

struct BookListView: View {
    @StateObject private var vm = BookListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if let err = vm.errorMessage {
                    VStack(spacing: 12) {
                        Text(err).foregroundStyle(.red)
                        Button("Retry") { Task { await vm.load() } }
                    }
                } else {
                    List(vm.filteredBooks) { book in
                        NavigationLink(value: book) {
                            topLevelHStack(book)
                        }
                    }
                    .refreshable { await vm.load() }
                    .searchable(text: $vm.searchText, prompt: "Search by title or author")
                }
            }
            .navigationTitle("Books")
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book, isFavorite: vm.isFavorite(book), toggleFavorite: {
                    vm.toggleFavorite(book)
                })
            }
            .task { if vm.filteredBooks.isEmpty { await vm.load() } }
        }
    }
}

struct topLevelHStack: View {
    let book: Book
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: book.thumbnailURL) { phase in
                switch phase {
                case .success(let img): img.resizable().scaledToFill()
                case .failure(_): Color.gray.opacity(0.2)
                case .empty: ProgressView()
                @unknown default: Color.gray.opacity(0.2)
                }
            }
            .frame(width: 50, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title).font(.headline)
                Text(book.author).font(.subheadline).foregroundStyle(.secondary)
                HStack(spacing: 2) {
                    ForEach(0..<5) { i in
                        Image(systemName: i < Int(round(book.rating)) ? "star.fill" : "star")
                            .font(.caption)
                    }
                }
            }
            Spacer()
            Button {
                vm.toggleFavorite(book)
            } label: {
                Image(systemName: vm.isFavorite(book) ? "heart.fill" : "heart")
                    .foregroundStyle(vm.isFavorite(book) ? .red : .secondary)
            }
            .buttonStyle(.plain)
        }
    }

}
