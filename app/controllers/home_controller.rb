class HomeController < ApplicationController
  def index
    @company = Company.last
    @dishes = Dish.last(15)
    @news = New.last(3)
  end

  def about
    @company = Company.last
  end
end
