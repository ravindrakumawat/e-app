class ContactInfosController < ApplicationController
  before_action :load_business
  before_action :set_contact_info, only: %i[ show edit update destroy ]

  def index
    @contact_infos = @business.contact_infos.all
  end

  def show
  end

  def new
    @contact_info = @business.contact_infos.build
  end

  def edit
  end

  def create
    @contact_info = @business.contact_infos.build(contact_info_params)

    respond_to do |format|
      if @contact_info.save
        format.html { redirect_to business_contact_infos_url, notice: "Contact info was successfully created." }
        format.json { render :show, status: :created, location: @contact_info }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact_info.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact_info.update(contact_info_params)
        format.html { redirect_to business_contact_infos_url, notice: "Contact info was successfully updated." }
        format.json { render :show, status: :ok, location: @contact_info }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact_info.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact_info.destroy
    respond_to do |format|
      format.html { redirect_to business_contact_infos_url, notice: "Contact info was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_contact_info
      @contact_info = @business.contact_infos.find(params[:id])
    end

    def contact_info_params
      params.fetch(:contact_info, {}).permit(:contact_type, :contact)
    end
end
