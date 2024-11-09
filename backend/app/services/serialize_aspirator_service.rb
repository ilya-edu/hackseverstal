require 'dry/monads'

class SerializeAspiratorService
  include Dry::Monads[:result, :do]
  def call(aspirator, batch_time)
    aspirator_current_status = aspirator.status
    sensor_payload = yield SerializeSensorsPayloadService.new.call(aspirator, batch_time)
    serialized_aspirator = Aspirator::ShowSerializer.new(aspirator, sensor_payload: sensor_payload, batch_time: batch_time, status: aspirator_current_status).as_json
    Success(serialized_aspirator)
  end
end
