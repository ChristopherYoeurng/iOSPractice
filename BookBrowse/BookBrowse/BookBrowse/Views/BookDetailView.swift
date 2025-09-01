//
//  BookDetailView.swift
//  BookBrowse
//
//  Created by Christopher Yoeurng on 8/23/25.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: Context) -> SFSafariViewController { SFSafariViewController(url: url) }
    func updateUIViewController(_ vc: SFSafariViewController, context: Context) {}
}

struct BookDetailView: View {
    let book: Book
    let isFavorite: Bool
    let toggleFavorite: () -> Void

    @State private var showPreview = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: book.coverURL) { phase in
                    switch phase {
                    case .success(let img): img.resizable().scaledToFit()
                    case .failure(_): Color.gray.opacity(0.2).frame(height: 200)
                    case .empty: ProgressView().frame(height: 200)
                    @unknown default: Color.gray.opacity(0.2).frame(height: 200)
                    }
                }
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(book.title).font(.title.bold())
                        Text(book.author).font(.title3).foregroundStyle(.secondary)
                        HStack(spacing: 2) {
                            ForEach(0..<5) { i in
                                Image(systemName: i < Int(round(book.rating)) ? "star.fill" : "star")
                                    .font(.caption)
                            }
                        }
                    }
                    Spacer()
                    Button {
                        toggleFavorite()
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundStyle(isFavorite ? .red : .secondary)
                    }
                    .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
                }

                Text(book.description).font(.body)

                if let preview = book.previewURL {
                    Button("Open Preview") { showPreview = true }
                        .buttonStyle(.borderedProminent)
                        .sheet(isPresented: $showPreview) {
                            SafariView(url: preview)
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
