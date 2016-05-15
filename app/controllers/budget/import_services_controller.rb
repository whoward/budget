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

      respond_to do |format|
        if @import_service.save
          format.html do
            flash[:notice] = 'import service was successfully created.'
            redirect_to edit_import_service_url(@import_service)
          end
          format.json { render action: 'show', status: :created, location: @import_service }
        else
          format.html { render action: 'new' }
          format.json { render json: @import_service.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @import_service.update(import_service_params)
          format.html do
            flash[:notice] = 'import service was successfully updated.'
            redirect_to edit_import_service_url(@import_service)
          end
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @import_service.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @import_service.destroy
      respond_to do |format|
        format.html { redirect_to import_services_url }
        format.json { head :no_content }
      end
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
