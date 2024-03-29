class CreateIndices < ActiveRecord::Migration
  def change
    create_table :indices do |t|
      t.string :name
      t.string :page_title
      t.text :keywords
      t.text :page_description
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end
