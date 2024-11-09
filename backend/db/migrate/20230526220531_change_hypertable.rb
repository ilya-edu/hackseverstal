class ChangeHypertable < ActiveRecord::Migration[7.0]
  def change
    drop_table :signal_values
  end
end
