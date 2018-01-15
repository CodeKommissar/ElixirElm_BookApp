defmodule BooksApp.Products.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias BooksApp.Products.Book


  schema "books" do
    field :amazonUrl, :string
    field :imageUrl, :string
    field :rating, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Book{} = book, attrs) do
    book
    |> cast(attrs, [:title, :rating, :amazonUrl, :imageUrl])
    |> validate_required([:title, :rating, :amazonUrl, :imageUrl])
  end
end