defmodule BooksAppWeb.Router do
  use BooksAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BooksAppWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", BooksAppWeb do
   pipe_through :api
   
   resources "/books", BookController, except: [:new, :edit]
  end
end
