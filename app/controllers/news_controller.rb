class NewsController < ApplicationController
  def index
    @news = New.page params[:page]
    @company = Company.last
  end

  def show
    @new = New.find(params[:id])
    @news = New.last(10)
  end
end
