class Post < ActiveRecord::Base
  belongs_to :blog

  validates_presence_of :body, :blog
  validates_length_of :body, :maximum => DB_TEXT_MAX_LENGTH
end
