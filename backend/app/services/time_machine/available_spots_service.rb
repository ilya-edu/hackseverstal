require 'dry/monads'

class TimeMachine::AvailableSpotsService
  include Dry::Monads[:result, :do]
  def call
    first_data = SignalValue.order(:batch_time).first
    last_data = SignalValue.order(:batch_time).last
    r = {
      minimum_moment: first_data.batch_time,
      maximum_moment: last_data.batch_time

    }
    Success(r)
  end
end
