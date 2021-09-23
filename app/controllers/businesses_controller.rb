class BusinessesController < ApplicationController
  before_action :set_business, only: %i[ edit update destroy ]

  def index
    @businesses = if search_key = params[:search_str]
                    @businesses = BusinessLookup.new.suggest(search_key)
                  else
                    Business.all.as_json(only: [:name, :logo, :domain])
                  end  
  end

  def show
    unless @business = Business.find_by(domain: params[:query])
      if business_data = BusinessLookup.new.lookup(params[:query])
        @business = Business.new(business_data)
        if @business.save
          return redirect_to @business
        end
      end
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
      params.fetch(:business, {}).permit(:name, :about, :address, :city ,:state ,:post_code, :country, :contact_email, :phone_number, :owner_name, :founded_date, :no_of_employees, :owner_id)
    end
end
