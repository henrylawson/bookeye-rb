class AddNewFields < ActiveRecord::Migration
  def up
    drop_table :books
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :year
      t.boolean :hasRead
      t.boolean :hasCopy
      t.boolean :hasEbook
      
      t.timestamps
    end
  end

  def down
  end
end
