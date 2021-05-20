class ChangeUrlToPosterUrlToMovies < ActiveRecord::Migration[6.0]
  def change
    rename_column :movies, :url, :poster_url
  end
end
