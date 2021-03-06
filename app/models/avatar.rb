class Avatar < ActiveRecord::Base
    belongs_to :user

    has_attachment :content_type => :image,
        :storage => :file_system,
        :max_size => 200.kilobytes,
        :resize_to => '200x200>' ,
        :thumbnails => {
            :small => '80x80>',
        }

   # validates_as_attachment

end
