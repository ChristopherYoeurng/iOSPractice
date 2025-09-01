
Assignment (60 min)

Implement a two-screen SwiftUI app:

Book List

Fetch books from BookAPI.fetchBooks().

Show title, author, rating (⭐️ xN), and a small thumbnail.

Add search that filters by title or author (client-side is fine).

Add pull-to-refresh to re-load data.

Tapping a row pushes Book Detail.

Toggling a star on a row sets/unsets Favorite and persists it.

Book Detail

Show cover image, title, author, rating, description.

Favorite toggle appears here too (mirrors list).

If the book has a previewURL, show “Open Preview” that opens SFSafariViewController (via SafariView wrapper).

Requirements

SwiftUI NavigationStack

@State, @StateObject, @ObservedObject, @Environment

Async/await networking (simulated via the provided service)

Local persistence via @AppStorage storing a set of IDs (or UserDefaults wrapper)

Basic error handling + retry UI

Unit test for at least one ViewModel behavior

Commit progressively (no giant “final” commit)

Notes

Networking is mocked; BookAPI reads MockData.json and simulates latency/errors.

No 3rd-party packages.

iOS 17+ target.

Stretch (only after core is done)

Sort segment (e.g., “Title”, “Author”, “Rating”).

Offline cache of last successful fetch to show something on launch if fetch fails.

Accessibility labels & Dynamic Type sanity.
