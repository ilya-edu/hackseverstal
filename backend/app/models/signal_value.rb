class SignalValue < ApplicationRecord
  extend Enumerize
  COUNT_CACHE_KEY = 'signal_values_count'
  self.primary_key = 'identifier'
  default_scope { order(:batch_time) }
  acts_as_hypertable time_column: :batch_time
  acts_as_time_vector time_column: "batch_time",
                      value_column: "value",
                      segment_by: "signal_kind_id"
  enumerize :status, in: %w[ok alarm warning]
  belongs_to :signal_kind
  has_one :aspirator, through: :signal_kind
  validates :batch_time, presence: true

  after_create ->{Rails.cache.write(COUNT_CACHE_KEY, nil)}
  after_destroy ->{Rails.cache.write(COUNT_CACHE_KEY, nil)}

  def self.count
    return Rails.cache.read(COUNT_CACHE_KEY) if Rails.cache.read(COUNT_CACHE_KEY).present?
    Rails.cache.write(COUNT_CACHE_KEY, super )
    Rails.cache.read(COUNT_CACHE_KEY) || super
  end

  def signal_kind_code
    signal_kind&.code
  end
  def signal_kind_short_name
    signal_kind&.short_name
  end
  def signal_kind_dimension
    signal_kind&.dimension
  end
  def set_status!
    return nil if value.nil?

    update_column('status', determine_status)
  end

  def determine_status
    if alarm_max && value > alarm_max
      :alarm
    elsif alarm_min && value < alarm_min
      :alarm
    elsif warning_max && value > warning_max
      :warning
    elsif warning_min && value < warning_min
      :warning
    else
      :ok
    end
  end

  def test_status
    %w[alarm warning ok].sample
  end
end
