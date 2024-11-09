class CreateDsFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :ds_files do |t|

      t.timestamps
    end
  end
end
