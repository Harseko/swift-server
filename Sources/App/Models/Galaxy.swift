import Vapor
import Fluent

final class Entity: Model, Content {
    // Name of the table or collection.
    static let schema = "test"

    // Unique identifier for this Galaxy.
    @ID(key: .id)
    var id: UUID?

    // The Galaxy's name.
    @Field(key: "sample")
    var sample: String

    // Creates a new, empty Galaxy.
    init() { }

    // Creates a new Entity with all properties set.
    init(id: UUID? = nil, sample: String) {
        self.id = id
        self.sample = sample
    }
}
