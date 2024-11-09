class DsFile::ShowSerializer < BaseSerializer
  attributes :id, :filename, :url, :file_type, :created_at, :rows_count, :rows_created
  def filename
    object.file.filename
  end
  def url
    object.file.url
  end
  def file_type
    object.file.filename.extension
  end
end