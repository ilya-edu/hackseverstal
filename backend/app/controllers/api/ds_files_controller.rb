class Api::DsFilesController < ApiController
  def index
    render json: ActiveModelSerializers::SerializableResource.new(DsFile.all.order(id: :desc),
                                                                  each_serializer: ::DsFile::ShowSerializer
    ).as_json
  end

  def create
    ds_file = DsFile.create(file: params.require(:file))
    CreateDsFileDatumJob.perform_async(ds_file.id)
    render json: ::DsFile::ShowSerializer.new(ds_file).as_json
  end
  def destroy
    DsFile.find(params[:id]).destroy
  end
end
