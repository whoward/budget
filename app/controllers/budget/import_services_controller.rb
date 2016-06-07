# frozen_string_literal: true
module Budget
  class ImportServicesController < BaseController
    before_action :set_import_service, only: [:show, :edit, :update, :destroy]

    def index
      @import_services = ImportService.all
    end

    def new
      @import_service = ImportService.new
    end

    def edit
    end

    def create
      @import_service = ImportService.new(import_service_params)

      if @import_service.save
        redirect_to action: :index, notice: 'import service was successfully created.'
      else
        render action: 'new'
      end
    end

    def update
      if @import_service.update(import_service_params)
        redirect_to action: :index, notice: 'import service was successfully updated.'
      else
        render action: 'edit'
      end
    end

    def destroy
      @import_service.destroy
      redirect_to action: :index, notice: 'import service deleted'
    end

    private

    def set_import_service
      @import_service = ImportService.find(params[:id])
    end

    def import_service_params
      params.require(:import_service).permit(:name, :type, :active, *per_type_params)
    end

    def per_type_params
      @import_service.try(:defined_preferences) || []
    end
  end
end
