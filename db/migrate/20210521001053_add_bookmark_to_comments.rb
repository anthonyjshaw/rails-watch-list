class AddBookmarkToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :bookmark, foreign_key: true
  end
end
