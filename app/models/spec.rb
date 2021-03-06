class Spec < ActiveRecord::Base
  belongs_to :user

  ALL_FIELDS = %w(first_name last_name )
  STRING_FIELDS = %w(first_name last_name )
  START_YEAR = 1920
  VALID_DATES = DateTime.new(START_YEAR)..DateTime.now
  
  validates_length_of STRING_FIELDS,
                      :maximum => DB_STRING_MAX_LENGTH
  validates_inclusion_of :birthdate,
                        :in => VALID_DATES,
                        :allow_nil => true,
                        :message => "is invalid"
  def full_name
    [first_name, last_name].join(" ")
  end

end
