//
//  Book.swift
//  BookBrowse
//
//  Created by Christopher Yoeurng on 8/23/25.
//

import Foundation

struct Book: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let author: String
    let rating: Double
    let thumbnailURL: URL?
    let coverURL: URL?
    let description: String
    let previewURL: URL?
}
