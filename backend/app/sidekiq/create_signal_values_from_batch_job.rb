class CreateSignalValuesFromBatchJob
  include Sidekiq::Job
  def perform(signal_batch)
    SignalValue.primary_key = nil
    CreateSignalValuesService.new.call(signal_batch)
  end
end