class HomeController < ApplicationController
  def index
  end

  def about
    @company = Company.last
  end

  def contact_us
    @company = Company.last
  end
end
