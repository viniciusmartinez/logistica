class HomeController < ApplicationController
  before_filter :require_user
  respond_to :html, :js
  
  def index
    @overdue_tasks = current_user.tasks.overdue
    @today_tasks = current_user.tasks.incomplete.due_to_today.limit(5)
    @this_week_tasks = current_user.tasks.incomplete.due_to_this_week.limit(5)
    @next_week_tasks = current_user.tasks.incomplete.due_to_next_week.limit(5)
    
    @today_birthdays = current_user.contacts.select{ |c| c.has_birthday_today? }
    @tomorrow_birthdays = current_user.contacts.select{ |c| c.has_birthday_tomorrow? }
    @next_birthdays = current_user.contacts.select{ |c| c.birthday.present? and !c.has_birthday_today? and !c.has_birthday_tomorrow? }.sort_by(&:next_birthday)[0..5]
        
    @last_contacts = current_user.contacts.favorites.main
    # ptbr_client = Weatherman::Client.new :lang => 'pt-br'
    # res = ptbr_client.lookup_by_woeid 455827
    # @location = res.location['city'] + ', ' + res.location['region']
    # @condition = res.condition
    # @d_or_n = Time.zone.now.hour >= 18 ? "n" : "d"
    # @weather_icon = "http://l.yimg.com/a/i/us/nws/weather/gr/#{ @condition['code'] }#{ @d_or_n }.png"
  end
  
  def summary
    @when = params[:when] || 1
    
    @start = Time.zone.today.beginning_of_month
    @end = Time.zone.today.end_of_month+1.day
    
    case @when
      when "2" then # last month
        @start = (Time.zone.today.beginning_of_month-1.day).beginning_of_month
        @end = (Time.zone.today.beginning_of_month-1.day).end_of_month+1.day
      when "3" then # 2 months ago
        @start = ((Time.zone.today.beginning_of_month-1.day).beginning_of_month-1.day).beginning_of_month
        @end = ((Time.zone.today.beginning_of_month-1.day).beginning_of_month-1.day).end_of_month+1.day
    end
    
    @contacts = current_user.contacts.where( :created_at => (@start)..(@end) ).order("created_at DESC")
    @notes = current_user.notes.where( :date => (@start)..(@end) ).order("date DESC")
    @tasks = current_user.tasks.where( :due_at => (@start)..(@end) ).order("due_at DESC")
  end
  
  def search
    @search_contacts = current_user.contacts.search_everything(params[:content])
    @search_notes = current_user.notes.search_everything(params[:content])
    @search_tasks = current_user.tasks.search_everything(params[:content])
  end
  
  def search_city
    @data = Contact.search_by(:city, params[:term]).select{ |c| c.city.present? }.collect{ |c| c.city }.uniq
    render :json => @data.collect{ |c| {:value => "#{c}", :label => "#{c}"} }
  end
  
  def search_occupation
    @data = Contact.search_by(:occupation, params[:term]).select{ |c| c.occupation.present? }.collect{ |c| c.occupation }.uniq
    render :json => @data.collect{ |c| {:value => "#{c}", :label => "#{c}"} }
  end
  
  def search_weather
    if !params[:term].empty?
      require 'net/http'
      require 'rexml/document'
    
      @url = "http://xoap.weather.com/search/search?where=#{params[:term]}"
      response = Net::HTTP.get_response(URI.parse(URI.encode(@url))).body
      xml = REXML::Document.new response
      @locations = []
      xml.elements['search'].elements.each('loc') do |e|
        @locations << { :id => e.attributes['id'], :value => e.text, :label => e.text }
      end
      render :json => @locations
    else
      render :nothing => true
    end
  end
end
