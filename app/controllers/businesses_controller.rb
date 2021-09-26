class BusinessesController < ApplicationController
  before_action :set_business, only: %i[ edit update destroy ]

  def index
    @businesses = Business.search(params[:search_str])
  end

  def show
    @business = Business.find_by(id: params[:id]) || Business.search_or_create_by_domin(params[:query])
    unless @business
      flash[:error] = 'Business Not Found'
      redirect_to businesses_url
    end
  end

  def new
    @business = Business.new
  end

  def edit
  end

  def create
    @business = Business.new(business_params)
    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: "Business was successfully created." }
        format.json { render :show, status: :created, location: @business }
      else
        flash.now[:error] = @business.errors.full_messages.join(", ")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: "Business was successfully updated." }
        format.json { render :show, status: :ok, location: @business }
      else
        flash.now[:error] = @business.errors.full_messages.join(", ")
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: "Business was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_business
      @business = Business.find(params[:id])
    end

    def business_params
      params.fetch(:business, {}).permit(:name, :about, :address, :city ,:state ,:post_code, :country, :contact_email,
        :phone_number, :owner_name, :founded_date, :no_of_employees, :owner_id, :country, :company_name, :domain,
        contact_infos_attributes: [:contact_type, :contact], social_accounts_attributes: [:social_network, :handle, :account_details])
    end
end
