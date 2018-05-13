# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dirble = Dirble.new(ENV['DIRBLE_TOKEN'])

# Get Radio Categories
categories = dirble.categories
categories.each do |category|
  category.symbolize_keys!
  Category.where(category).first_or_create
end

# Get Radio Stations
stations = dirble.stations
stations.each do |station|
  station.symbolize_keys!
  categories = station[:categories]
  streams = station[:streams]
  [:categories, :streams].each { |k| station.delete(k) }

  # Add station
  station[:remote_logo_url] = station[:image]['url'] if station[:image].present? && station[:image]['url'].present?
  station.delete(:image)
  st = Station.find_by("settings ->> 'dirble_id' = '#{station[:id]}'")
  next if st.present?

  station[:dirble_id] = station.delete(:id)
  st = Station.create(station)

  # Find or add Categories
  categories.each do |category|
    category.symbolize_keys!
    cat = Category.where(category).first_or_create
    st.categories << cat
  end

  # Add Station Streams
  streams.each do |stream|
    stream.symbolize_keys!
    stream[:url] = stream.delete(:stream)
    st.streams.create(stream)
  end
end
