class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :title
      t.date :date
      t.string :area_id
      t.integer :postal
      t.text :place
      t.string :venue
      t.integer :capacity
      t.text :remarks
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
