1) Para poner a funcionar el proyecto "books_app":
  1.- En la terminal -> mix phx.server
  
2) Para añadir un nuevo libro:
  1. Dentro de "books_app", en la terminal -> iex -S mix phx.server
  2. Luego, manualmente corremos este comando -> BooksApp.Products.create_book(%{title: "tituloDelLibro", rating: Intde1a10(pero no 6), amazonUrl: "link a amazon", imageUrl: "link a imagen del libro en amazon"})

3) Para hostear el sitio en heroku:
  https://github.com/elixir-elm-tutorial/elixir-elm-tutorial-book/blob/master/manuscript/phoenix_testing_and_deployment.md
  

TODO:
  1. Crear ruta "/login"
  2. Crear ruta "books/new"
  3. Crear ruta "books/:id/edit"
  4. Crear ruta "books/:id/delete"
  5. Crear sus respectivos controladores
  6. Manejar la autentacion para solo poder crear/editar/eliminar libros si estas logeado