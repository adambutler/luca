import Foundation

struct Demo {
    static let production = URL(string: "https://luca.labfoo.dev")!

    /// Update this to choose which demo is run
    static var current: URL {
        production
    }
}
