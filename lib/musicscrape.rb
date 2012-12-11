require 'rubygems'
require 'rest-client'
#This gem goes to www.thestranger.com/seattle/Music and scrapes data for all the recommended concerts. 
#The intent is to have it put them on your google calendar but it hasn't gotten that far yet. 


class Scrape
  #Scrape is meant to parse www.thestranger.com/music and pull out info on the recommended shows
  #initialize with source_type = :web and url = "http://www.thestranger.com/music"
  def initialize(source_type,url)
    @source_type = source_type
    @url = url
  end

  def load_page
    #Uses RestClient to get the html
    if @source_type == :web then
      (RestClient.get(@url))
    else
      open("#{File.dirname(__FILE__)}/stranger.txt", &:read)
    end
  end

  def remove_excess(text_in)
    #removes everthing except the recommended events section
    text_in = text_in.partition("<h2 class=\"sitesection\">Recommended Music Events</h2>").drop(1).join
    text_in.partition("<li class=")[0..1].join.strip
  end
  
  def open_local
    #opens a local file for testing
    open("#{File.dirname(__FILE__)}/stranger.txt", &:read)
  end
  
  def get_events(text_in)
    #parses the html after it has been pared down and returns an array of hashes containing the data
    #returns [[:title=> "", :venue=>"", :date=>"", :details=>""], ...]
    @music_text = text_in
    #while there are still events left do this
    event_array = []
    partition_array = [[:title,'</a><br/>'],[:venue,'<br />'],[:date,'<br />'],[:details,'</li>']] #fields we want to get and what to use for partition
    n=0
    while @music_text.include? "http://www.thestranger.com/seattle/Event?event="
      event_hash = {}
      @music_text = @music_text.partition(/\bevent=\b\d*.*/)[2] #pull off the stuff at the front
      partition_array.each do |id|
        my_array = @music_text.partition(id[1])
        event_hash[id[0]] = my_array[0].strip #the bit before the partition
        @music_text = my_array[2] #the bit after the partition
      end
      event_hash[:details]= event_hash[:details].split().join(",")
      event_array[n] = event_hash
      n+=1
    end
    event_array
  end
  
end

class Google
  attr_writer :password
  attr_writer :user
  attr_writer :title
  attr_writer :venue
  attr_writer :date
  attr_writer :details
  require "rubygems"
  require "gcal4ruby"
  
  
  def convert(event_date)
    #convert a stranger date to a google date
    #find out what day of the week today is
    #assume that Sun...Sat are the next one
    #{0=>'Sun', 1=>'Mon', 2=>'Tues', 3=>'Wed', 4=>'Thurs', 5=> 'Fri', 6=>'Sat', 
    day_array=[0,1,2,3,4,5,6] #to make subtracted days of week wrap around
    day_hash = {:Sun=>0,:Mon=>1,:Tue=>2, :Wed=>3,:Thurs=>4,:Fri=>5,:Sat=>6}
    month_hash = {:Jan=>1, :Feb=>2, :Mar=>3, :Apr=>4, :May=>5, :Jun=>6, :Jul=>7, :Aug=>8, :Sep=>9,:Oct=>10, :Nov=>11, :Dec=>12 }
    current_time = Time.now
    current_day = current_time.wday
    date_array = event_date.split(" ")
    if date_array.size == 3
      #if it's 3 words assume the format is Day Month Date
      event_day = day_hash[date_array[0].capitalize.to_sym]
      event_month = month_hash[date_array[1].capitalize.to_sym]
      event_date = date_array[2].to_i
      event_time = Time.local(current_time.year,event_month,event_date)
    else
      #it's going to be in the form 'Every Mon' but we will only put it on for this week
      event_day = day_hash[date_array[1].capitalize.to_sym] #find the number 0 to 6 for event day
      event_time = current_time + (60*60*24*day_array[event_day - current_day])#get the differential from todays day
    end
    event_time
  end
  
  def create_event(title, venue, date, details)
    @date = convert(date)
    serv = GCal4Ruby::Service.new
    serv.authenticate "fakeemail@gmail.com", "fakepassword"
    calendar = GCal4Ruby::Calendar.new(serv)
    event = GCal4Ruby::Event.new(calendar)
        event.title = @title
        event.start_time = @date
        event.end_time = @date + 60*60 #add an hour for the end time
        event.where = @venue
        event.send 
        
  end

end
