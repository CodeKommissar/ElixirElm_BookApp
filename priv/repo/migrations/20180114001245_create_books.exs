defmodule BooksApp.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :rating, :integer
      add :amazonUrl, :string
      add :imageUrl, :string

      timestamps()
    end

  end
end
