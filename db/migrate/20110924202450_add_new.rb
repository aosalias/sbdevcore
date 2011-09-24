class AddNew < ActiveRecord::Migration
  def change
    change_column_default(:photos, :klass, "center")
    change_table :indices do |t|
      t.string :slug
      t.integer :priority
      t.string :title
    end
  end

  def down
  end
end
