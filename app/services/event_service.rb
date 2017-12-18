require 'open-uri'
require 'json'
require 'nokogiri'

class EventService

# before_action :set_events
# before_action :set_names_of_events

def initialize(attributes={})
  @city = attributes[:city]
  @category = attributes[:category]
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
    api_events = JSON.parse(open("http://api.eventful.com/json/events/search?app_key=#{ENV["EVENTFUL"]}&page_size=250&image_sizes=block100,large,dropshadow250&l=#{@city}").read)
    api_events["events"]["event"].each do |event|
      new_event = Event.new
        new_event.name = event["title"]
        # new_event.category = "Other"
        # new_event.subcategory = "Other"
        if event["image"] == nil
          new_event.photo = "https://picsum.photos/200/300/?random"
        else
          new_event.photo = event["image"]["large"]["url"]
        end
        new_event.start_time = event["start_time"]
        new_event.end_time = event["stop_time"]
        new_event.street_address = event["venue_address"]
        new_event.city = event["city_name"]
        new_event.country = event["country_name"]
        new_event.eventful_id = event["id"]
        new_event.description = event["description"]
        new_event.venue_name = event["venue_name"]
        new_event.user_id = User.find_by_email("pierrealexis@gmail.com").id

      if @array_of_names.include?(new_event.name)
        # puts "#{new_event.name} already exists"
      else
        file      = open("http://api.eventful.com/rest/events/get?app_key=#{ENV["EVENTFUL"]}&id=#{new_event.eventful_id}").read
        document  = Nokogiri::XML(file)
        new_event.category = document.css("categories id").first.text
        new_event.subcategory = new_event.category
        new_event.save
      end
    end
end

end
