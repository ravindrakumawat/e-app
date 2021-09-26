class ApplicationController < ActionController::Base

  private
    def load_business
      @business = Business.find(params[:business_id])
    end
end
