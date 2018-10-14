class Stream < ApplicationRecord
  belongs_to :station
  before_validation :strip_whitespace
  enum status: [:pending, :active]

  before_save :check_stream

  def icy_metadata
    options = {}
    stream = Shoutout::Stream.new(url)

    begin
      stream.connect
      options[:name] = stream.name
      options[:description] = stream.description
      options[:genre] = stream.genre
      options[:notice] = stream.notice
      options[:bitrate] = stream.bitrate
      options[:is_public] = stream.public?
      options[:content_type] = stream.content_type

      Timeout.timeout(5) do
        options[:website] = stream.website
        options[:now_playing] = stream.now_playing
      end

      options[:server] = stream.inspect.delete('"').scan(/server\=\>(\S+)\s(\d)/).flatten
    rescue SocketError, Timeout::Error
      {}
    ensure
      stream.disconnect
    end
    OpenStruct.new(options)
  end

  private

  def strip_whitespace
    url.try(:strip!)
  end

  def check_stream
    data = icy_metadata
    raise "Invalid or unsupported Stream url - #{url}." unless data.present?

    self.content_type = data.content_type
    self.bitrate = data.bitrate
    self.status = 1
  end
end
