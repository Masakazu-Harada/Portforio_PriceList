module ApplicationHelper
  def format_date(date)
    wday = ["日", "月", "火", "水", "木", "金", "土"]
    date.strftime("%Y年%m月%d日(#{wday[date.wday]})")
  end
end
