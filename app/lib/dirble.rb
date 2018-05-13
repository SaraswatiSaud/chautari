# dirble = Dirble.new('e425f14053b0eff05fdc1624e0')
# stations = dirble.stations

class Dirble
  attr_reader :token
  include HTTParty
  base_uri 'api.dirble.com/v2'

  def initialize(token)
    @token = token
  end

  def stations
    url = '/stations'
    process_request(url)
  end

  def recent_stations
    url = '/stations/recent'
    process_request(url)
  end

  def popular_stations
    url = '/stations/popular'
    process_request(url)
  end

  def station(id)
    return unless id.present?
    url = '/stations' + id
    process_request(url)
  end

  def similar_stations(id)
    return unless id.present?
    url = '/stations' + id + '/similar'
    process_request(url)
  end

  def categories
    url = '/categories/primary'
    process_request(url)
  end

  def category_stations(id)
    return unless id.present?
    url = '/category/' + id + '/stations'
    process_request(url)
  end

  def search(query)
    return unless query.present?
    url = '/search'
    options = {
      query: query
    }
    process_request(url, options, 'post')
  end

  private

  def process_request(url, options = {}, method = 'get')
    url = url + '?token=' + token
    get_response(url, options, method).parsed_response
  end

  def get_response(url, options, method)
    if method == 'get'
      self.class.get(url, options)
    elsif method == 'post'
      self.class.post(url, query: options)
    end
  end
end
