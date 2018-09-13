class Stream < ApplicationRecord
  belongs_to :station
  before_validation :strip_whitespace
  enum status: [:pending, :active]

  before_save :check_stream

  def icy_metadata
    stream = Shoutout::Stream.new(url)
    begin
      if stream.connect
        options = {}
        options[:name] = stream.name
        options[:description] = stream.description
        options[:genre] = stream.genre
        options[:notice] = stream.notice
        options[:bitrate] = stream.bitrate
        options[:is_public] = stream.public?
        options[:content_type] = stream.content_type

        begin
          Timeout::timeout(5) do
            options[:website] = stream.website
            options[:now_playing] = stream.now_playing
          end
        rescue
        end
        OpenStruct.new(options)
      end
    rescue
      {}
    ensure
      stream.disconnect
    end
  end

  private

  def strip_whitespace
    self.url.try(:strip!)
  end

  def check_stream
    data = self.icy_metadata
    raise "Invalid or unsupported Stream url - #{self.url}." unless data.present?

    self.content_type = data.content_type
    self.bitrate = data.bitrate
    self.status = 1
  end
end
