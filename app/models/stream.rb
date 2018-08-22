class Stream < ApplicationRecord
  belongs_to :station
  before_validation :strip_whitespace
  enum status: [:pending, :active]

  before_save :check_stream

  def icy_metadata
    stream = Shoutout::Stream.new(url)
    Timeout::timeout(5) do
      if stream.connect
        OpenStruct.new(
          name: stream.name,
          description: stream.description,
          genre: stream.genre,
          notice: stream.notice,
          bitrate: stream.bitrate,
          is_public: stream.public?,
          now_playing: stream.now_playing,
          content_type: stream.content_type,
          website: stream.website
        )
      end
    end
  rescue => e
    {}
  ensure
    stream.disconnect
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
