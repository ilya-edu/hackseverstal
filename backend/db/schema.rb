# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_26_220553) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "timescaledb"
  enable_extension "uuid-ossp"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "aspirators", force: :cascade do |t|
    t.bigint "sinter_machine_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rotor_name"
    t.datetime "rotor_change_date"
    t.integer "last_offset"
    t.index ["sinter_machine_id"], name: "index_aspirators_on_sinter_machine_id"
  end

  create_table "controlled_parameters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.integer "position", default: 0
  end

  create_table "ds_file_data", force: :cascade do |t|
    t.datetime "dt"
    t.bigint "ds_file_id"
    t.float "jeksgauster_4._tok_rotora_1"
    t.float "jeksgauster_4._tok_rotora2"
    t.float "jeksgauster_4._tok_statora"
    t.float "jeksgauster_4._davlenie_masla_v_sisteme"
    t.float "jeksgauster_4._temperatura_podshipnika_na_opore_1"
    t.float "jeksgauster_4._temperatura_podshipnika_na_opore_2"
    t.float "jeksgauster_4._temperatura_podshipnika_na_opore_3"
    t.float "jeksgauster_4._temperatura_podshipnika_na_opore_4"
    t.float "jeksgauster_4._temperatura_masla_v_sisteme"
    t.float "jeksgauster_4._temperatura_masla_v_maslobloke"
    t.float "jeksgauster_4._vibraciya_na_opore_1"
    t.float "jeksgauster_4._vibraciya_na_opore_2"
    t.float "jeksgauster_4._vibraciya_na_opore_3"
    t.float "jeksgauster_4._vibraciya_na_opore_3._prodolnaya."
    t.float "jeksgauster_4._vibraciya_na_opore_4"
    t.float "jeksgauster_4._vibraciya_na_opore_4._prodolnaya."
    t.float "jeksgauster_5._tok_rotora_1"
    t.float "jeksgauster_5._tok_rotora_2"
    t.float "jeksgauster_5._tok_statora"
    t.float "jeksgauster_5._davlenie_masla_v_sisteme"
    t.float "jeksgauster_5._temperatura_podshipnika_na_opore_1"
    t.float "jeksgauster_5._temperatura_podshipnika_na_opore_2"
    t.float "jeksgauster_5._temperatura_podshipnika_na_opore_3"
    t.float "jeksgauster_5._temperatura_podshipnika_na_opore_4"
    t.float "jeksgauster_5._temperatura_masla_v_sisteme"
    t.float "jeksgauster_5._temperatura_masla_v_maslobloke"
    t.float "jeksgauster_5._vibraciya_na_opore_1"
    t.float "jeksgauster_5._vibraciya_na_opore_2"
    t.float "jeksgauster_5._vibraciya_na_opore_3"
    t.float "jeksgauster_5._vibraciya_na_opore_3._prodolnaya."
    t.float "jeksgauster_5._vibraciya_na_opore_4"
    t.float "jeksgauster_5._vibraciya_na_opore_4._prodolnaya."
    t.float "jeksgauster_6._tok_rotora_1"
    t.float "jeksgauster_6._tok_rotora_2"
    t.float "jeksgauster_6._tok_statora"
    t.float "jeksgauster_6._davlenie_masla_v_sisteme"
    t.float "jeksgauster_6._temperatura_podshipnika_na_opore_1"
    t.float "jeksgauster_6._temperatura_podshipnika_na_opore_2"
    t.float "jeksgauster_6._temperatura_podshipnika_na_opore_3"
    t.float "jeksgauster_6._temperatura_podshipnika_na_opore_4"
    t.float "jeksgauster_6._temperatura_masla_v_sisteme"
    t.float "jeksgauster_6._temperatura_masla_v_maslobloke"
    t.float "jeksgauster_6._vibraciya_na_opore_1"
    t.float "jeksgauster_6._vibraciya_na_opore_2"
    t.float "jeksgauster_6._vibraciya_na_opore_3"
    t.float "jeksgauster_6._vibraciya_na_opore_3._prodolnaya."
    t.float "jeksgauster_6._vibraciya_na_opore_4"
    t.float "jeksgauster_6._vibraciya_na_opore_4._prodolnaya."
    t.float "jeksgauster_7._tok_rotora_1"
    t.float "jeksgauster_7._tok_rotora_2"
    t.float "jeksgauster_7._tok_statora"
    t.float "jeksgauster_7._davlenie_masla_v_sisteme"
    t.float "jeksgauster_7._temperatura_podshipnika_na_opore_1"
    t.float "jeksgauster_7._temperatura_podshipnika_na_opore_2"
    t.float "jeksgauster_7._temperatura_podshipnika_na_opore_3"
    t.float "jeksgauster_7._temperatura_podshipnika_na_opore_4"
    t.float "jeksgauster_7._temperatura_masla_v_sisteme"
    t.float "jeksgauster_7._temperatura_masla_v_maslobloke"
    t.float "jeksgauster_7._vibraciya_na_opore_1"
    t.float "jeksgauster_7._vibraciya_na_opore_2"
    t.float "jeksgauster_7._vibraciya_na_opore_3"
    t.float "jeksgauster_7._vibraciya_na_opore_3._prodolnaya."
    t.float "jeksgauster_7._vibraciya_na_opore_4"
    t.float "jeksgauster_7._vibraciya_na_opore_4._prodolnaya."
    t.float "jeksgauster_8._tok_rotora_1"
    t.float "jeksgauster_8._tok_rotora_2"
    t.float "jeksgauster_8._tok_statora"
    t.float "jeksgauster_8._davlenie_masla_v_sisteme"
    t.float "jeksgauster_8._temperatura_podshipnika_na_opore_1"
    t.float "jeksgauster_8._temperatura_podshipnika_na_opore_2"
    t.float "jeksgauster_8._temperatura_podshipnika_na_opore_3"
    t.float "jeksgauster_8._temperatura_podshipnika_na_opore_4"
    t.float "jeksgauster_8._temperatura_masla_v_sisteme"
    t.float "jeksgauster_8._temperatura_masla_v_maslobloke"
    t.float "jeksgauster_8._vibraciya_na_opore_1"
    t.float "jeksgauster_8._vibraciya_na_opore_2"
    t.float "jeksgauster_8._vibraciya_na_opore_3"
    t.float "jeksgauster_8._vibraciya_na_opore_3._prodolnaya."
    t.float "jeksgauster_8._vibraciya_na_opore_4"
    t.float "jeksgauster_8._vibraciya_na_opore_4._prodolnaya."
    t.float "jeksgauster_9._tok_rotora_1"
    t.float "jeksgauster_9._tok_rotora_2"
    t.float "jeksgauster_9._tok_statora"
    t.float "jeksgauster_9._davlenie_masla_v_sisteme"
    t.float "jeksgauster_9._temperatura_podshipnika_na_opore_1"
    t.float "jeksgauster_9._temperatura_podshipnika_na_opore_2"
    t.float "jeksgauster_9._temperatura_podshipnika_na_opore_3"
    t.float "jeksgauster_9._temperatura_podshipnika_na_opore_4"
    t.float "jeksgauster_9._temperatura_masla_v_sisteme"
    t.float "jeksgauster_9._temperatura_masla_v_maslobloke"
    t.float "jeksgauster_9._vibraciya_na_opore_1"
    t.float "jeksgauster_9._vibraciya_na_opore_2"
    t.float "jeksgauster_9._vibraciya_na_opore_3"
    t.float "jeksgauster_9._vibraciya_na_opore_3._prodolnaya."
    t.float "jeksgauster_9._vibraciya_na_opore_4"
    t.float "jeksgauster_9._vibraciya_na_opore_4._prodolnaya."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ds_file_id"], name: "index_ds_file_data_on_ds_file_id"
  end

  create_table "ds_files", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rows_count"
    t.boolean "rows_created", default: false
  end

  create_table "evraz_kafka_data", force: :cascade do |t|
    t.jsonb "payload"
    t.string "key"
    t.string "md5_payload"
    t.integer "offset"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issue_requests", force: :cascade do |t|
    t.bigint "signal_value_id", null: false
    t.string "name"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["signal_value_id"], name: "index_issue_requests_on_signal_value_id"
  end

  create_table "play_machine_data", force: :cascade do |t|
    t.jsonb "payload"
    t.string "key"
    t.string "md5_payload"
    t.integer "offset"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "signal_kinds", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "kafka_code"
    t.string "type_of_signal"
    t.string "active_ibahd"
    t.bigint "device_kind_id"
    t.bigint "controlled_parameter_id"
    t.bigint "value_kind_id"
    t.bigint "aspirator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_name"
    t.string "dimension"
    t.float "alarm_max"
    t.float "alarm_min"
    t.float "warning_max"
    t.float "warning_min"
    t.boolean "show_notification_on_main_page", default: true
    t.index ["aspirator_id"], name: "index_signal_kinds_on_aspirator_id"
    t.index ["controlled_parameter_id"], name: "index_signal_kinds_on_controlled_parameter_id"
    t.index ["device_kind_id"], name: "index_signal_kinds_on_device_kind_id"
    t.index ["value_kind_id"], name: "index_signal_kinds_on_value_kind_id"
  end

  create_table "signal_values", id: false, force: :cascade do |t|
    t.bigint "signal_kind_id", null: false
    t.float "value"
    t.float "alarm_max"
    t.float "warning_max"
    t.float "alarm_min"
    t.float "warning_min"
    t.integer "offset"
    t.datetime "batch_time", null: false
    t.string "status"
    t.uuid "identifier", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_time"], name: "signal_values_batch_time_idx", order: :desc
  end

  create_table "sinter_machines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "value_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "aspirators", "sinter_machines"
  add_foreign_key "signal_kinds", "aspirators"
  add_foreign_key "signal_kinds", "controlled_parameters"
  add_foreign_key "signal_kinds", "device_kinds"
  add_foreign_key "signal_kinds", "value_kinds"
  create_hypertable "signal_values", time_column: "batch_time", chunk_time_interval: "1 day", compress_segmentby: "signal_kind_id", compress_orderby: "batch_time ASC", compression_interval: "P7D"
end
