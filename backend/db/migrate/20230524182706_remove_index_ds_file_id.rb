class RemoveIndexDsFileId < ActiveRecord::Migration[7.0]
  def change
    remove_index :ds_file_data, :ds_file_id
    change_column :ds_file_data, :ds_file_id, :bigint,foreign_key: false
  end
end
