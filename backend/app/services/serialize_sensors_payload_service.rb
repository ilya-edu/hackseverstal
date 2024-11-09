require 'dry/monads'

class SerializeSensorsPayloadService
  attr_reader :aspirator, :batch_time

  include Dry::Monads[:result, :do]
  def call(aspirator, batch_time )
    @aspirator = aspirator
    @batch_time = batch_time
    r = {}
    r[:bearings] = serialized_sensors_data_by_devices(%w[bearings])
    r[:other_senors] = serialized_sensors_data_by_devices(%w[work_aspirator support oil_system main_drive valve_position gas_manifold cooler])
    r
    Success(r)
  end

  def serialized_sensors_data_by_devices(device_kinds_sym)
    sensors_by_device_kinds(device_kinds_sym).sort do |a, b|
      a[0].position <=> b[0].position
    end.map do |device_kind, signal_values|
      {
        device_kind: DeviceKind::ShortSerializer.new(device_kind),
        signal_values: ActiveModelSerializers::SerializableResource.new(signal_values,
                                                                        each_serializer: SignalValue::ShowSerializer
                                                                       ).as_json
      }
    end
  end

  def sensors_by_device_kinds(device_kinds_sym)
    signal_kind_ids = aspirator.signal_kinds.select { |sk| device_kinds_sym.include? sk.device_kind.kind }.map(&:id)
    SignalValue.includes(:signal_kind, signal_kind: [:device_kind]).where(signal_kind_id: signal_kind_ids, batch_time: batch_time).group_by do |sv|
      sv.signal_kind.device_kind
    end
  end
end
