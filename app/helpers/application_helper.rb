module ApplicationHelper
  def title(page_title = '')
    default_title = '| Stream Radio Online | Chautari'
    content_for(:title) { "#{page_title} #{default_title}" }
    if page_title.present?
      "#{page_title} #{default_title}"
    else
      'Chautari | Stream Radio from globe | News, Music, Sports and more'
    end
  end
end
