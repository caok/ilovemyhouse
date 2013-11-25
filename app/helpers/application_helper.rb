module ApplicationHelper
  def format_date(datetime)
    if datetime.nil?
      datetime
    elsif datetime == "0"
      "不存在"
    else
      datetime.strftime("%Y-%m-%d")
    end
  end
end
