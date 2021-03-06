class CreateBlogPosts < ActiveRecord::Migration
  def self.up
    create_table :blog_posts, :options => 'default charset=utf8' do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :blog_posts
  end
end
