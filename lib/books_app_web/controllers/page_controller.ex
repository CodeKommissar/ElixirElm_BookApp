defmodule BooksAppWeb.PageController do
  use BooksAppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
