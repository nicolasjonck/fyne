class EventsController < ApplicationController
  before_action :set_event, only:[:show, :edit, :update, :destroy]
  before_action :set_user, only:[:show, :new, :create, :edit, :update, :destroy]

  def index
    @group_of_events = Event.all
    # .order(start_time: :asc).group("DATE_TRUNC('day', start_time)")
    #Afterwards, need to do where swipe.interested = true or where swipe.event.user = current_user
  end

  def show
    # event = EventService.new.call
    #afterwards, need to do booking

    # add when latitude and long added to event model:
    # @event = Event.where.not(latitude: nil, longitude: nil)
    @marker = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.photo == nil
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
      @event.photo = hash_of_images[@event.category.to_sym]
    end

    current_user.save

    if @event.save
      flash[:notice] = "Congrats, your event #{@event.name} has been created!"
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @event = Event.find(params[:id])
    compile_subcats
    format_subcats
  end

  def update
    @event.update(event_params)
    @event.save
    if @event.save
      flash[:notice] = "Your event #{@event.name} has been successfully updated"
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to new_swipe_path
  end


  private

  def event_params
    params.require(:event).permit(:name, :user, :category, :subcategory, :start_time, :end_time, :street_address, :city, :zip_code, :state, :country, :photo, :photouploaded, :url, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def compile_subcats

    # Subcat hash definition
    @subcats_hash = {};
    @subcats_hash["music"] = ["music", "music_blues",  "music_classical",  "music_country",  "music_dance",  "music_easy_listening", "music_electronic", "music_folk", "music_jazz", "music_latin",  "music_newage", "music_opera",  "music_rb", "music_reggae", "music_vocal",  "music_rap_hiphop", "music_metal",  "music_religious",  "music_rock", "music_pop",  "music_world",  "music_alternative",  "music_childrens"];
    @subcats_hash["conference"] = ["conference", "conference_career", "conference_convention", "conference_seminar", "conference_talkslectures"];
    @subcats_hash["comedy"] = ["comedy"];
    @subcats_hash["learning_education"] = ["learning_education", "learning_education_classworkshop"];
    @subcats_hash["family_fun_kids"] = ["family_fun_kids"];
    @subcats_hash["festivals_parades"] = ["festivals_parades", "festivals_parades_circus", "festivals_parades_festival", "festivals_parades_fairs", "festivals_parades_parade"];
    @subcats_hash["movies_film"] = ["movies_film", "movies_film_filmfestival"];
    @subcats_hash["food"] = ["food", "food_beer", "food_wine", "food_farmersmarket", "food_tastings"];
    @subcats_hash["fundraisers"] = ["fundraisers", "fundraisers_blooddrive", "fundraisers_volunteer"];
    @subcats_hash["art"] = ["art",
    "art_antiques",
    "art_painting",
    "art_photography",
    "art_artexhibits",
    "art_artsandcrafts",
    "art_fashion"];
    @subcats_hash["support"] = ["support",
    "support_fitness",
    "support_seniorhealth",
    "support_support",
    "support_yoga"];
    @subcats_hash["holiday"] = ["holiday"];
    @subcats_hash["books"] = ["books",
    "books_poetry"];
    @subcats_hash["attractions"] = ["attractions"];
    @subcats_hash["community"] = ["community",
    "community_library",
    "community_holiday",
    "community_seasonal"];
    @subcats_hash["business"] = ["business"];
    @subcats_hash["singles_social"] = ["singles_social",
    "singles_social_trivianight",
    "singles_social_comedy",
    "singles_social_bars",
    "singles_social_dating",
    "singles_social_karaoke",
    "singles_social_openmic"];
    @subcats_hash["schools_alumni"] = ["schools_alumni"];
    @subcats_hash["clubs_associations"] = ["clubs_associations"];
    @subcats_hash["outdoors_recreation"] = ["outdoors_recreation",
    "outdoors_recreation_cycling",
    "outdoors_recreation_hiking",
    "outdoors_recreation_nature",
    "outdoors_recreation_running"];
    @subcats_hash["performing_arts"] = ["performing_arts",
    "performing_arts_cabaret",
    "performing_arts_opera",
    "performing_arts_dance",
    "performing_arts_musical",
    "performing_arts_ballet",
    "performing_arts_comedy",
    "performing_arts_theatre"];
    @subcats_hash["animals"] = ["animals",
    "animals_cats",
    "animals_dogs"];
    @subcats_hash["politics_activism"] = ["politics_activism"];
    @subcats_hash["sales"] = ["sales",
    "sales_auction",
    "sales_craftshow",
    "sales_fleamarket",
    "sales_yardsale",
    "sales_retail"];
    @subcats_hash["science"] = ["science"];
    @subcats_hash["religion_spirituality"] = ["religion_spirituality"];
    @subcats_hash["sports"] = ["sports",
    "sports_autoracing",
    "sports_dance",
    "sports_gymnastics",
    "sports_iceskatingskiing",
    "sports_softball",
    "sports_swimmingdiving",
    "sports_volleyball",
    "sports_baseball",
    "sports_basketball",
    "sports_cricket",
    "sports_football",
    "sports_golf",
    "sports_hockey",
    "sports_rugby",
    "sports_soccer",
    "sports_tennis",
    "sports_wrestling"];
    @subcats_hash["technology"] = ["technology",
    "technology_computer"];
    @subcats_hash["other"] = ["other"];

    @subcats_hash["Films & Series"] = ["Action", "Animation", "Biography", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "History", "Horror", "Musical", "Romance", "Sport", "War", "Western"];
    @subcats_hash["Sports"] = ["Football", "Rugby", "Tennis", "Formula 1", "Auto/moto", "Basket", "Handball", "Golf", "Cycle", "Winter sports", "Athletism", "Swimming", "Volley-ball", "Other sports"];
    @subcats_hash["Games"] = ["Games"];
    @subcats_hash["Wellness & Health"] = ["Dancing", "Fitness", "Health"];
    @subcats_hash["Spirituality"] = ["Spirituality"];
    @subcats_hash["Non-profit"] = ["Non-profit"];
    @subcats_hash["Tasting & Restauration"] = ["Food tasting", "Drink tasting"];
    @subcats_hash["Crafting"] = ["Crafting (General)", "Gardening", "Home"];
    @subcats_hash["Party"] = ["Party"];
    @subcats_hash["Business"] = ["Networking", "Shopping", "Conference"];
    @subcats_hash["Politics"] = ["Politics"];
    @subcats_hash["Other"] = ["Other"];

  end

  def format_subcats
    raw_subcat = @subcats_hash[@event.category] - [@event.subcategory]
    @formatted_subcats = raw_subcat.unshift(@event.subcategory)
  end

end
