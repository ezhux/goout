class CreateStudyPrograms < ActiveRecord::Migration
  def self.up
    create_table :study_programs , :options => 'default charset=utf8' do |t|
      t.string :title
      t.integer :subject_area_id

      t.timestamps
    end
  end

  def self.down
    drop_table :study_programs
  end
end
