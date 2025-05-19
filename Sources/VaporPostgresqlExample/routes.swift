import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("add") { req async throws -> String in
        let sampleTodos = [
            Todo(title: "Comprar leite"),
            Todo(title: "Fazer exercícios"),
            Todo(title: "Estudar Swift"),
            Todo(title: "Ler um livro"),
            Todo(title: "Meditar")
        ]
        
        try await sampleTodos.create(on: req.db)
        return "Adicionados \(sampleTodos.count) todos de exemplo!"
    }

    app.get("result") { req async throws -> [TodoDTO] in
        let todos = try await Todo.query(on: req.db).all()
        return todos.map { $0.toDTO() }
    }

    try app.register(collection: TodoController())
}
