class BusOperatorsController < ApplicationController
  before_action :update_bus_operators, only: :index
  before_action :set_bus_operator, only: [:show, :edit, :update]

  def index
    @bus_operators = BusOperator.order(@order_selected)
                                .page(params[:page])
                                .per(20)
  end

  def show
    @review = @bus_operator.reviews.build
  end

  def edit
  end

  def update
    if @bus_operator.update(bus_operator_params)
      render :show
    else
      render :edit
    end
  end

  private
  def update_bus_operators
    BusOperator.update
  end

  def set_bus_operator
    @bus_operator = BusOperator.find(params[:id])
  end

  def bus_operator_params
    @order_selected = params.require(:bus_operator).permit(:description)
  end

  def bus_operator_order_params
    params[:bus_operator].try(:[], 'order_by')
  end
end
