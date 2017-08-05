class AddBookIdToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :book_id, :integer
  end
end
