require 'dry/monads'
require 'csv'

class ImportSignalKindService
  include Dry::Monads[:result, :do]
  attr_reader :rows

  def call(path)
    SignalKind.destroy_all
    DeviceKind.destroy_all
    ControlledParameter.destroy_all
    ValueKind.destroy_all
    @rows = handle_parquet_file(path)
    Success('ok')
  end

  def handle_parquet_file(path)
    table = Polars.read_parquet(path)
    table.columns[1..].each do |column|
      options = detect_options(column)
      SignalKind.create(
        name: column,
        value_kind: options[2],
        dimension: options[1],
        device_kind: options[0],
        aspirator: Aspirator.find_or_create_by(name: column.match(/ЭКСГАУСТЕР \d/).to_s)
      )
    end
  end
  def detect_options(column)
    without_aspirator_name = column.remove(/ЭКСГАУСТЕР \d\.\W?/)
    case without_aspirator_name
    when /ТОК РОТОРА 1$|ТОК РОТОРА2$|ТОК РОТОРА 2$|ТОК СТАТОРА$/
      [DeviceKind.find_or_create_by(name: "Главный привод", kind: :main_drive),
       'А'
      ]
    when /ДАВЛЕНИЕ МАСЛА В СИСТЕМЕ$/
      [DeviceKind.find_or_create_by(name: "Маслосистема", kind: :oil_system), 'кг\см²']
    when /ТЕМПЕРАТУРА МАСЛА В СИСТЕМЕ$|ТЕМПЕРАТУРА МАСЛА В МАСЛОБЛОКЕ$/
      [DeviceKind.find_or_create_by(name: "Маслосистема", kind: :oil_system), '°С']
    when /ТЕМПЕРАТУРА ПОДШИПНИКА НА ОПОРЕ 1$/
      [DeviceKind.find_or_create_by(name: "Подшипник на опоре 1", kind: :bearings), '°С']
    when /ТЕМПЕРАТУРА ПОДШИПНИКА НА ОПОРЕ 2$/
      [DeviceKind.find_or_create_by(name: "Подшипник на опоре 2", kind: :bearings), '°С']
    when /ТЕМПЕРАТУРА ПОДШИПНИКА НА ОПОРЕ 3$/
      [DeviceKind.find_or_create_by(name: "Подшипник на опоре 3", kind: :bearings), '°С']
    when /ТЕМПЕРАТУРА ПОДШИПНИКА НА ОПОРЕ 4$/
      [DeviceKind.find_or_create_by(name: "Подшипник на опоре 4", kind: :bearings), '°С']
    when /ВИБРАЦИЯ НА ОПОРЕ 1$/
      [DeviceKind.find_or_create_by(name: "Опора 1", kind: :support), 'мм\с']
    when /ВИБРАЦИЯ НА ОПОРЕ 2$/
      [DeviceKind.find_or_create_by(name: "Опора 2", kind: :support), 'мм\с']
    when /ВИБРАЦИЯ НА ОПОРЕ 3$/
      [DeviceKind.find_or_create_by(name: "Опора 3", kind: :support), 'мм\с']
    when /ВИБРАЦИЯ НА ОПОРЕ 3\. ПРОДОЛЬНАЯ\.$/
      [DeviceKind.find_or_create_by(name: "Опора 3", kind: :support), 'мм\с', ValueKind.find_or_create_by(name: "Продольная")]
    when /ВИБРАЦИЯ НА ОПОРЕ 4$/
      [DeviceKind.find_or_create_by(name: "Опора 4", kind: :support), 'мм\с']
    when /ВИБРАЦИЯ НА ОПОРЕ 4\. ПРОДОЛЬНАЯ\.$/
      [DeviceKind.find_or_create_by(name: "Опора 4", kind: :support), 'мм\с', ValueKind.find_or_create_by(name: "Продольная")]
    else
      puts column
      raise "can't detect device kind"
    end
  end
end
