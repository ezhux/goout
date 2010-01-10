class RenameStudyToActivity < ActiveRecord::Migration
  def self.up
    drop_table :studies
    create_table :activities, :options => 'default charset=utf8' do |t|
      t.string :type
      t.integer :user_id
      t.integer :organization_id
	  t.integer :study_program_id
      t.integer :exchange_program_id
      t.integer :activity_area_id
      t.date :from
      t.date :to
      t.timestamps
    end

  end

  def self.down
  end
end
