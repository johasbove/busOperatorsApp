class ReviewsController < ApplicationController
  before_action :set_bus_operator, only: :index
  def index
    @reviews = @bus_operator.reviews
                           .page(params[:page])
                           .per(20)
  end

  private

  def set_bus_operator
    @bus_operator = BusOperator.find(params[:bus_operator_id])
  end
end
