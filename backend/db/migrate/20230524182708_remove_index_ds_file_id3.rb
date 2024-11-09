class RemoveIndexDsFileId3 < ActiveRecord::Migration[7.0]
  def change
    change_column :ds_file_data, :ds_file_id, :bigint,foreign_key: false
    add_index :ds_file_data, :ds_file_id
  end
end
