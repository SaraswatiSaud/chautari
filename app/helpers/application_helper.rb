module ApplicationHelper
  def title(page_title = '')
    if page_title.present?
      "#{page_title} | Listen Radio Online | Chautari"
    else
      'Listen to Radio Stations from the globe | Chautari'
    end
  end
end
