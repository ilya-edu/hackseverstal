class AddCoulmnsToDsFile < ActiveRecord::Migration[7.0]
  def change
    add_column :ds_files, :rows_count, :integer
    add_column :ds_files, :rows_created, :boolean, default: false
  end
end
