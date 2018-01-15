defmodule BooksAppWeb.BookController do
  use BooksAppWeb, :controller

  alias BooksApp.Products
  alias BooksApp.Products.Book

  action_fallback BooksAppWeb.FallbackController

  def index(conn, _params) do
    books = Products.list_books()
    render(conn, "index.json", books: books)
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Products.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", book_path(conn, :show, book))
      |> render("show.json", book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Products.get_book!(id)
    render(conn, "show.json", book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Products.get_book!(id)

    with {:ok, %Book{} = book} <- Products.update_book(book, book_params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Products.get_book!(id)
    with {:ok, %Book{}} <- Products.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
