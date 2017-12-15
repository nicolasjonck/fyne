require 'open-uri'
require 'json'

class EventService

# before_action :set_events
# before_action :set_names_of_events

def Initialize(args)
  @city = args[:city]
end

def call
  50.times do
    get_events
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
    api_events = JSON.parse(open("http://api.eventful.com/json/events/search?app_key=#{ENV["EVENTFUL"]}&l=Barcelona").read)
    api_events["events"]["event"].each do |event|
      new_event = Event.new
        new_event.name = event["title"]
        new_event.category = "Other"
        new_event.subcategory = "Other"
        if event["image"] == nil
          new_event.photo = "https://picsum.photos/200/300/?random"
        else
          puts "#{new_event.name} has a phototo upload"
          new_event.photo = event["image"]["medium"]["url"]
        end
        new_event.start_time = event["start_time"]
        new_event.end_time = event["stop_time"]
        new_event.street_address = event["venue_address"]
        new_event.city = event["city_name"]
        # new_event.zip_code = event["city_name"]
        new_event.country = event["country_name"]
        new_event.user_id = User.find_by_email("pierrealexis@gmail.com").id
      if @array_of_names.include?(new_event.name)
        puts "#{new_event.name} already exists"
      else
        new_event.save
        puts "#{new_event.name} has been created"
        puts "#{Event.count} events in total"
      end
    end
end


end
