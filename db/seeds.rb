# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dirble = Dirble.new(ENV['DIRBLE_TOKEN'])

# Get Radio Categories
unless Category.any?
  categories = dirble.categories
  categories.each do |category|
    category.symbolize_keys!
    Category.where(category).first_or_create
  end
end

# Get Radio Stations
unless Station.any?
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
end

# Add Admin User
User.create(email: 'admin@chautari.online', password: 'testing1234', is_admin: true)

# Add General User
User.create(email: 'general@chautari.online', password: 'testing1234')

# Add Languages
languages = 'Afrikanns,Albanian,Arabic,Armenian,Basque,Bengali,Bulgarian,Catalan,
  Cambodian,Chinese (Mandarin),Croation,Czech,Danish,Dutch,English,Estonian,Fiji,
  Finnish,French,Georgian,German,Greek,Gujarati,Hebrew,Hindi,Hungarian,Icelandic,
  Indonesian,Irish,Italian,Japanese,Javanese,Korean,Latin,Latvian,Lithuanian,
  Macedonian,Malay,Malayalam,Maltese,Maori,Marathi,Mongolian,Nepali,Norwegian,
  Persian,Polish,Portuguese,Punjabi,Quechua,Romanian,Russian,Samoan,Serbian,
  Slovak,Slovenian,Spanish,Swahili,Swedish ,Tamil,Tatar,Telugu,Thai,Tibetan,
  Tonga,Turkish,Ukranian,Urdu,Uzbek,Vietnamese,Welsh,Xhosa'
languages.split(',').each { |l| Language.where(title: l).first_or_create }
