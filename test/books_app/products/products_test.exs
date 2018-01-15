defmodule BooksApp.ProductsTest do
  use BooksApp.DataCase

  alias BooksApp.Products

  describe "books" do
    alias BooksApp.Products.Book

    @valid_attrs %{amazonUrl: "some amazonUrl", imageUrl: "some imageUrl", rating: 42, title: "some title"}
    @update_attrs %{amazonUrl: "some updated amazonUrl", imageUrl: "some updated imageUrl", rating: 43, title: "some updated title"}
    @invalid_attrs %{amazonUrl: nil, imageUrl: nil, rating: nil, title: nil}

    def book_fixture(attrs \\ %{}) do
      {:ok, book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_book()

      book
    end

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Products.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Products.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      assert {:ok, %Book{} = book} = Products.create_book(@valid_attrs)
      assert book.amazonUrl == "some amazonUrl"
      assert book.imageUrl == "some imageUrl"
      assert book.rating == 42
      assert book.title == "some title"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      assert {:ok, book} = Products.update_book(book, @update_attrs)
      assert %Book{} = book
      assert book.amazonUrl == "some updated amazonUrl"
      assert book.imageUrl == "some updated imageUrl"
      assert book.rating == 43
      assert book.title == "some updated title"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_book(book, @invalid_attrs)
      assert book == Products.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Products.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Products.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Products.change_book(book)
    end
  end
end
