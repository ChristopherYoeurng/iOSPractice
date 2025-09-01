//
//  Tests.swift
//  Tests
//
//  Created by Christopher Yoeurng on 8/23/25.
//

import Testing
@testable import BookBrowse

struct Tests {

    @Test func example() async throws {
        let vm = await MainActor.run { BookListViewModel() }
        let b = Book(id: "x", title: "T", author: "A", rating: 4, thumbnailURL: nil, coverURL: nil, description: "", previewURL: nil)

        await MainActor.run {
            assert(!vm.isFavorite(b))
            vm.toggleFavorite(b)
            assert(vm.isFavorite(b))
            vm.toggleFavorite(b)
            assert(!vm.isFavorite(b))
        }

    }

}
