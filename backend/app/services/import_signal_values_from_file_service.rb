require 'dry/monads'
require 'csv'

class ImportSignalValuesFromFileService
  include Dry::Monads[:result, :do]

  def call(filepath)
    table = Polars.read_parquet(filepath)
    table[4842336..].each_row do |batch|
      CreateSignalValuesFromBatchJob.perform_async(batch)
    end
    Success('Signals created')
  end

  def logger
    @logger ||= Logger.new('log/import_batch_signals_log.log')
  end
end
