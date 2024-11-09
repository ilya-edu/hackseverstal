require 'parquet'
class CreateSignalValuesFromDsFileJob
  include Sidekiq::Job
  sidekiq_options retry: false
  def perform(ds_file_id)
    Rails.logger.info("Create ds file data start with id #{ds_file_id}")
    ds_file = DsFile.find(ds_file_id)
    DsFileDatum.where(ds_file: ds_file).delete_all
    create_file_datum(ds_file)
    ds_file.update(rows_created: true)
    Rails.logger.info("Create ds file data finished with id #{ds_file_id}")
  end
  def create_file_datum(ds_file)
    ds_file.update(rows_created: false)
    ds_file.file.open do |file|
      table = Polars.read_parquet(file.path)
      i = 0
      arr_payload = []
      table.each_row do |r|
        if i < 10000
          arr_payload.push(payload(r.values).merge(ds_file_id: ds_file.id))
          i += 1
        else
          puts Time.now
          DsFileDatum.insert_all(arr_payload)
          ds_file.update(rows_count: DsFileDatum.where(ds_file: ds_file).count)
          i = 0
          arr_payload = []
        end
      end
    end
  end
  def payload(r)
    {"dt"=>r[0],
     "jeksgauster_4._tok_rotora_1"=>r[1],
     "jeksgauster_4._tok_rotora2"=>r[2],
     "jeksgauster_4._tok_statora"=>r[3],
     "jeksgauster_4._davlenie_masla_v_sisteme"=>r[4],
     "jeksgauster_4._temperatura_podshipnika_na_opore_1"=>r[5],
     "jeksgauster_4._temperatura_podshipnika_na_opore_2"=>r[6],
     "jeksgauster_4._temperatura_podshipnika_na_opore_3"=>r[7],
     "jeksgauster_4._temperatura_podshipnika_na_opore_4"=>r[8],
     "jeksgauster_4._temperatura_masla_v_sisteme"=>r[9],
     "jeksgauster_4._temperatura_masla_v_maslobloke"=>r[10],
     "jeksgauster_4._vibraciya_na_opore_1"=>r[11],
     "jeksgauster_4._vibraciya_na_opore_2"=>r[12],
     "jeksgauster_4._vibraciya_na_opore_3"=>r[13],
     "jeksgauster_4._vibraciya_na_opore_3._prodolnaya."=>r[14],
     "jeksgauster_4._vibraciya_na_opore_4"=>r[15],
     "jeksgauster_4._vibraciya_na_opore_4._prodolnaya."=>r[16],
     "jeksgauster_5._tok_rotora_1"=>r[17],
     "jeksgauster_5._tok_rotora_2"=>r[18],
     "jeksgauster_5._tok_statora"=>r[19],
     "jeksgauster_5._davlenie_masla_v_sisteme"=>r[20],
     "jeksgauster_5._temperatura_podshipnika_na_opore_1"=>r[21],
     "jeksgauster_5._temperatura_podshipnika_na_opore_2"=>r[22],
     "jeksgauster_5._temperatura_podshipnika_na_opore_3"=>r[23],
     "jeksgauster_5._temperatura_podshipnika_na_opore_4"=>r[24],
     "jeksgauster_5._temperatura_masla_v_sisteme"=>r[25],
     "jeksgauster_5._temperatura_masla_v_maslobloke"=>r[26],
     "jeksgauster_5._vibraciya_na_opore_1"=>r[27],
     "jeksgauster_5._vibraciya_na_opore_2"=>r[28],
     "jeksgauster_5._vibraciya_na_opore_3"=>r[29],
     "jeksgauster_5._vibraciya_na_opore_3._prodolnaya."=>r[30],
     "jeksgauster_5._vibraciya_na_opore_4"=>r[31],
     "jeksgauster_5._vibraciya_na_opore_4._prodolnaya."=>r[32],
     "jeksgauster_6._tok_rotora_1"=>r[33],
     "jeksgauster_6._tok_rotora_2"=>r[34],
     "jeksgauster_6._tok_statora"=>r[35],
     "jeksgauster_6._davlenie_masla_v_sisteme"=>r[36],
     "jeksgauster_6._temperatura_podshipnika_na_opore_1"=>r[37],
     "jeksgauster_6._temperatura_podshipnika_na_opore_2"=>r[38],
     "jeksgauster_6._temperatura_podshipnika_na_opore_3"=>r[39],
     "jeksgauster_6._temperatura_podshipnika_na_opore_4"=>r[40],
     "jeksgauster_6._temperatura_masla_v_sisteme"=>r[41],
     "jeksgauster_6._temperatura_masla_v_maslobloke"=>r[42],
     "jeksgauster_6._vibraciya_na_opore_1"=>r[43],
     "jeksgauster_6._vibraciya_na_opore_2"=>r[44],
     "jeksgauster_6._vibraciya_na_opore_3"=>r[45],
     "jeksgauster_6._vibraciya_na_opore_3._prodolnaya."=>r[46],
     "jeksgauster_6._vibraciya_na_opore_4"=>r[47],
     "jeksgauster_6._vibraciya_na_opore_4._prodolnaya."=>r[48],
     "jeksgauster_7._tok_rotora_1"=>r[49],
     "jeksgauster_7._tok_rotora_2"=>r[50],
     "jeksgauster_7._tok_statora"=>r[51],
     "jeksgauster_7._davlenie_masla_v_sisteme"=>r[52],
     "jeksgauster_7._temperatura_podshipnika_na_opore_1"=>r[53],
     "jeksgauster_7._temperatura_podshipnika_na_opore_2"=>r[54],
     "jeksgauster_7._temperatura_podshipnika_na_opore_3"=>r[55],
     "jeksgauster_7._temperatura_podshipnika_na_opore_4"=>r[56],
     "jeksgauster_7._temperatura_masla_v_sisteme"=>r[57],
     "jeksgauster_7._temperatura_masla_v_maslobloke"=>r[58],
     "jeksgauster_7._vibraciya_na_opore_1"=>r[59],
     "jeksgauster_7._vibraciya_na_opore_2"=>r[60],
     "jeksgauster_7._vibraciya_na_opore_3"=>r[61],
     "jeksgauster_7._vibraciya_na_opore_3._prodolnaya."=>r[62],
     "jeksgauster_7._vibraciya_na_opore_4"=>r[63],
     "jeksgauster_7._vibraciya_na_opore_4._prodolnaya."=>r[64],
     "jeksgauster_8._tok_rotora_1"=>r[65],
     "jeksgauster_8._tok_rotora_2"=>r[66],
     "jeksgauster_8._tok_statora"=>r[67],
     "jeksgauster_8._davlenie_masla_v_sisteme"=>r[68],
     "jeksgauster_8._temperatura_podshipnika_na_opore_1"=>r[69],
     "jeksgauster_8._temperatura_podshipnika_na_opore_2"=>r[70],
     "jeksgauster_8._temperatura_podshipnika_na_opore_3"=>r[71],
     "jeksgauster_8._temperatura_podshipnika_na_opore_4"=>r[72],
     "jeksgauster_8._temperatura_masla_v_sisteme"=>r[73],
     "jeksgauster_8._temperatura_masla_v_maslobloke"=>r[74],
     "jeksgauster_8._vibraciya_na_opore_1"=>r[75],
     "jeksgauster_8._vibraciya_na_opore_2"=>r[76],
     "jeksgauster_8._vibraciya_na_opore_3"=>r[77],
     "jeksgauster_8._vibraciya_na_opore_3._prodolnaya."=>r[78],
     "jeksgauster_8._vibraciya_na_opore_4"=>r[79],
     "jeksgauster_8._vibraciya_na_opore_4._prodolnaya."=>r[80],
     "jeksgauster_9._tok_rotora_1"=>r[81],
     "jeksgauster_9._tok_rotora_2"=>r[82],
     "jeksgauster_9._tok_statora"=>r[83],
     "jeksgauster_9._davlenie_masla_v_sisteme"=>r[84],
     "jeksgauster_9._temperatura_podshipnika_na_opore_1"=>r[85],
     "jeksgauster_9._temperatura_podshipnika_na_opore_2"=>r[86],
     "jeksgauster_9._temperatura_podshipnika_na_opore_3"=>r[87],
     "jeksgauster_9._temperatura_podshipnika_na_opore_4"=>r[88],
     "jeksgauster_9._temperatura_masla_v_sisteme"=>r[89],
     "jeksgauster_9._temperatura_masla_v_maslobloke"=>r[90],
     "jeksgauster_9._vibraciya_na_opore_1"=>r[91],
     "jeksgauster_9._vibraciya_na_opore_2"=>r[92],
     "jeksgauster_9._vibraciya_na_opore_3"=>r[93],
     "jeksgauster_9._vibraciya_na_opore_3._prodolnaya."=>r[94],
     "jeksgauster_9._vibraciya_na_opore_4"=>r[95],
     "jeksgauster_9._vibraciya_na_opore_4._prodolnaya."=>r[96]
    }
  end
end
