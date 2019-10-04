class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :capital
      t.integer :times_visited
      t.integer :times_favorited
    end
  end
end
