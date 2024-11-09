class ChangeHypertable2 < ActiveRecord::Migration[7.0]
  def change
    hypertable_options = {
      time_column: 'batch_time',
      chunk_time_interval: '1 day',
      compress_segmentby: 'signal_kind_id',
      compress_orderby: 'batch_time',
      compression_interval: '7 days'
    }
    enable_extension "uuid-ossp"
    create_table(:signal_values, id: false, hypertable: hypertable_options) do |t|
      t.bigint :signal_kind_id, null: false
      t.float :value
      t.float :alarm_max
      t.float :warning_max
      t.float :alarm_min
      t.float :warning_min
      t.integer :offset
      t.datetime :batch_time
      t.string  :status
      t.uuid :identifier, default: "gen_random_uuid()", null: false
      t.timestamps
    end
  end
end
