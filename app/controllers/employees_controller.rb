class EmployeesController < ApplicationController
  before_action :load_business
  before_action :set_employee, only: %i[ show edit update destroy ]

  def index
    @employees = @business.employees.all
  end

  def show
  end

  def new
    @employee = @business.employees.new
  end

  def edit
  end

  def create
    @employee = @business.employees.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to [@business, @employee], notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to [@business, @employee], notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to business_employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_employee
      @employee = @business.employees.find(params[:id])
    end

    def employee_params
      params.fetch(:employee, {}).permit(:first_name, :last_name, :email, :designation, :joining_date)
    end

    def load_business
      @business = Business.find(params[:business_id])
    end
end
