# frozen_string_literal: true

# Stations Helper module
module StationsHelper
  def google_structured_data station
    data = {
      "@context": 'http://schema.org',
      "@type": 'RadioStation',
      "name": station.name.to_s,
      "url": station_url(station),
      "image": ENV['ROOT_URL'] + station.logo_url,
      "address": station.full_address,
      "telephone": '-'
    }

    if station.active_reviews.any?
      data['aggregateRating'] = {
        "@type": 'AggregateRating',
        "ratingValue": station.average_rating,
        "reviewCount": station.reviews_count
      }
    end
    javascript_tag data.to_json, type: 'application/ld+json'
  end

  def station_thumb(station)
    link_to station, remote: true do
      concat image_tag(station.logo_url, class: 'border img-fluid', alt: station.name)
      concat content_tag('span', station.name)
    end
  end
end
