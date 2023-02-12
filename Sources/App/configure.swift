import Vapor
import Fluent
import FluentMongoDriver


// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try app.databases.use(.mongo(connectionString: "mongodb+srv://swift_server:Nout42SL1uXM1M9v@cluster0.6waad.mongodb.net/sample_database?retryWrites=true&w=majority"),
                          as: .mongo)
    
    try routes(app)
}
