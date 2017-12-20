require 'open-uri'
require 'json'
require 'nokogiri'

class EventService

# before_action :set_events
# before_action :set_names_of_events

def initialize(attributes={})
  @city = attributes[:city]
  @category = attributes[:category]
  @size = attributes[:size] || 20
  # @size = attributes[:size]
end

def call
  number_of_created_events = Event.count
  puts "#{Event.count} available before the call"
  # 5.times do
    get_events
  # end
  puts "#{Event.count - number_of_created_events} NEW EVENTS HAVE BEEN CREATED :"
  array_of_new_events = Event.last(Event.count - number_of_created_events)
  array_of_new_events.each do |event|
  puts "#{event.id} - #{event.name}"
  end
end

def set_events
  @events = Event.all
end

def set_names_of_events
  events = Event.all
  @array_of_names = []
  events.each do |event|
    @array_of_names << event.name
  end
end

private

def get_events
  set_events
  set_names_of_events
    api_events = JSON.parse(open("http://api.eventful.com/json/events/search?app_key=#{ENV["EVENTFUL"]}&page_size=#{@size}&image_sizes=large,dropshadow250,blackborder500,block250&l=#{@city}").read)
    api_events["events"]["event"].each do |event|
      new_event = Event.new
        new_event.name = event["title"]
        # new_event.category = "Other"
        # new_event.subcategory = "Other"
        # if event["image"] == nil
        #   new_event.photo = "http://blog.daix.com/wp-content/uploads/2012/09/fond-d-ecran-noir-iphone-5"
        # else
        #   new_event.photo = event["image"]["block250"]["url"]
        # end
        new_event.start_time = event["start_time"]
        new_event.end_time = event["stop_time"]
        new_event.street_address = event["venue_address"]
        new_event.city = event["city_name"]
        new_event.country = event["country_name"]
        new_event.eventful_id = event["id"]

        if event["description"] != nil
          new_event.description = Nokogiri::HTML.fragment(event["description"]).text
          # fragment = Nokogiri::HTML.fragment(event["description"])
        end

        if event["venue_name"] != nil
          # new_event.venue_name = event["venue_name"]
          new_event.venue_name = Nokogiri::HTML.fragment(event["venue_name"]).text
        end


        # new_event.url = event["url"]
        new_event.user_id = User.find_by_email("pierrealexis@gmail.com").id

      if @array_of_names.include?(new_event.name)
        # puts "#{new_event.name} already exists"
      else
        file      = open("http://api.eventful.com/rest/events/get?app_key=#{ENV["EVENTFUL"]}&id=#{new_event.eventful_id}").read
        document  = Nokogiri::XML(file)
        new_event.category = document.css("categories id").first.text
        new_event.subcategory = new_event.category
        if document.css("links url").first != nil
          new_event.url = document.css("links url").first.text
        end

        if event["image"] == nil
          hash_of_images = {
          music: 'https://picsum.photos/200/300?image=452',
          conference: 'https://picsum.photos/200/300?image=677',
          comedy: 'https://picsum.photos/200/300?image=395',
          learning_education: 'https://picsum.photos/200/300?image=885',
          family_fun_kids: 'https://picsum.photos/200/300?image=838',
          festivals_parades: 'https://picsum.photos/200/300?image=145',
          movies_film: 'https://picsum.photos/200/300?image=91',
          food: 'https://picsum.photos/200/300?image=999',
          fundraisers: 'https://picsum.photos/200/300?image=513',
          art: 'https://picsum.photos/200/300?image=628',
          support: 'https://picsum.photos/200/300?image=773',
          holiday: 'https://picsum.photos/200/300?image=845',
          books: 'https://picsum.photos/200/300?image=1010',
          attractions: 'https://picsum.photos/200/300?image=252',
          community: 'https://picsum.photos/200/300?image=998',
          business: 'https://picsum.photos/200/300?image=1031',
          singles_social: 'https://picsum.photos/200/300?image=815',
          schools_alumni: 'https://picsum.photos/200/300?image=532',
          clubs_associations: 'https://picsum.photos/200/300?image=526',
          outdoors_recreation: 'https://picsum.photos/200/300?image=1057',
          performing_arts: 'https://picsum.photos/200/300?image=453',
          animals: 'https://picsum.photos/200/300?image=1025',
          politics_activism: 'https://picsum.photos/200/300?image=441',
          sales: 'https://picsum.photos/200/300?image=686',
          science: 'https://picsum.photos/200/300?image=967',
          religion_spirituality: 'https://picsum.photos/200/300?image=938',
          sports: 'https://picsum.photos/200/300?image=1058',
          technology: 'https://picsum.photos/200/300?image=949',
          other: 'https://picsum.photos/200/300?image=467',
        }
          new_event.photo = hash_of_images[new_event.category.to_sym]
        else
          new_event.photo = event["image"]["block250"]["url"]
        end

        new_event.save

      end
    end
end

end
