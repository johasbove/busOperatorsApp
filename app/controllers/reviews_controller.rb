class ReviewsController < ApplicationController
  before_action :set_bus_operator
  def index
    @reviews = @bus_operator.reviews
                            .page(params[:page])
                            .per(20)
  end

  def create
    @review = @bus_operator.reviews.build(review_params)
    if @review.save
      redirect_to bus_operator_reviews_path(@bus_operator)
    else
      redirect_to bus_operator_path(@bus_operator)
    end
  end

  private

  def set_bus_operator
    @bus_operator = BusOperator.find(params[:bus_operator_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :bus_operator_id)
  end
end
