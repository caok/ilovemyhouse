class DishesController < ApplicationController
  def index
    @dishes = Dish.page(params[:page]).per(6)
    @company = Company.last
  end

  def show
    @dish = Dish.find(params[:id])
    @company = Company.last
  end
end
