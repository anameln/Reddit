class AddParentCommentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_comment_id, :integer
  end

  add_index :comments, :parent_comment_id
end
