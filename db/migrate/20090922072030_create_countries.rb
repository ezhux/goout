class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries, :options => 'default charset=utf8' do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
