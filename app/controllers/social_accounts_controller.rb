class SocialAccountsController < ApplicationController
  before_action :load_business
  before_action :set_social_account, only: %i[ show edit update destroy ]

  def index
    @social_accounts = @business.social_accounts.all
  end

  def show
  end

  def new
    @social_account = @business.social_accounts.new
  end

  def edit
  end

  def create
    @social_account = @business.social_accounts.new(social_account_params)

    respond_to do |format|
      if @social_account.save
        format.html { redirect_to @social_account, notice: "Contact info was successfully created." }
        format.json { render :show, status: :created, location: @social_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @social_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @social_account.update(social_account_params)
        format.html { redirect_to @social_account, notice: "Contact info was successfully updated." }
        format.json { render :show, status: :ok, location: @social_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @social_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @social_account.destroy
    respond_to do |format|
      format.html { redirect_to social_accounts_url, notice: "Contact info was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_social_account
      @social_account = @business.social_accounts.find(params[:id])
    end

    def social_account_params
      params.fetch(:social_account, {}).permit(:contact_type, :contact)
    end
end
