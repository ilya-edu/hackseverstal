class RemoveIndexDsFileId2 < ActiveRecord::Migration[7.0]
  def change
    change_column :ds_file_data, :ds_file_id, :bigint,foreign_key: true
  end
end
