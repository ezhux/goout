class AssocPostsUser < ActiveRecord::Migration
  def self.up
    add_column (:posts, :user_id, :int)
  end

  def self.down
  end
end