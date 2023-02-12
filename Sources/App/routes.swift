import Vapor

func routes(_ app: Application) throws {
    app.get("entities") { req async throws -> [Entity] in
        try await Entity.query(on: req.db).all()
    }
    
    app.get("entities", ":id") { req async throws -> Entity in
        let id = UUID(uuidString:req.parameters.get("id")!)
        guard let entity = try await Entity.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        return entity
    }

    app.post("entities") { req in
        struct Request: Content {
            var name: String
        }
        let request = try req.content.decode(Request.self)

        let entity = Entity.init(sample: request.name)
        try await entity.create(on: req.db)
        return HTTPStatus.created
    }

     app.put("entities", ":id", "edit") { req async throws in
         struct Request: Content {
             var name: String
         }
         let request = try req.content.decode(Request.self)
         
         let id = UUID(uuidString: req.parameters.get("id")!)
         guard let entity = try await Entity.find(id, on: req.db) else {
             throw Abort(.notFound)
         }
         
         entity.sample = request.name
         try await entity.save(on: req.db)
         
         return HTTPStatus.ok
     }

     app.delete("entities", ":id") { req async throws -> HTTPStatus in
         let id = UUID(uuidString: req.parameters.get("id")!)
         guard let entity = try await Entity.find(id, on: req.db) else {
             throw Abort(.notFound)
         }
         try await entity.delete(on: req.db)
         return .noContent
     }
}
