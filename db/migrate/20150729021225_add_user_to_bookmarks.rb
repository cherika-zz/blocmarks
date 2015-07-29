class AddUserToBookmarks < ActiveRecord::Migration
  def change
    add_reference :bookmarks, :user, index: true
    add_foreign_key :bookmarks, :users
  end
end
