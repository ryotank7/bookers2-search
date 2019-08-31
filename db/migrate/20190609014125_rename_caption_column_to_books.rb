class RenameCaptionColumnToBooks < ActiveRecord::Migration[5.2]
  def change
  	rename_column :books, :caption, :body
  end
end
