# frozen_string_literal: true

module Budget
  class ImportServicesController < BaseController
    def index
      @import_services = ImportServiceRecord.to_a
    end

    def new
      @import_service = ImportServiceRecord.new
    end

    def edit
      @import_service = Cast::ImportServiceRecord(params[:id])
    end

    def create
      Command::ImportService::Create.new(import_service_params).call
      flash[:notice] = 'import service was successfully created.'
      redirect_to :index
    end

    def update
      Command::ImportService::Update.new(params[:id], import_service_params).call
      flash[:notice] = 'import service was successfully updated.'
      redirect_to :index
    end

    def destroy
      Command::ImportService::Delete.new(params[:id]).call
      flash[:notice] = 'import service deleted'
      redirect_to :index
    end

    private

    def import_service_params
      params.require(:import_service).permit(:name, :type, :active, *per_type_params)
    end

    def per_type_params
      @import_service.try(:defined_preferences) || []
    end
  end
end
