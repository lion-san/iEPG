# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'json'

class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.all
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @channel }
    end
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create

#=============================================

#Delay
delay = 0 #Second

#Define
station = "station:"
station_json = "station"
station_name = "station-name:"
station_name_json = "station_name"
year = "year:"
year_json = "year"
month = "month:"
month_json = "month"
date = "date:"
date_json = "date"
start_time = "start:"
start_time_json = "start_time"
end_time = "end:"
end_time_json = "end_time"
title = "program-title:"
title_json = "title"
subtitle = "program-subtitle:"
subtitle_json = "subtitle"
performer = "performer:"
performer_json = "performer"
subperformer = "subperformer:"
subperformer_json = "subperformer"
id = "program-id:"
id_json = "id"
genre = "genre-1:"
genre_json = "genre"
subgenre = "subgenre-1:"
subgenre_json = "subgenre"
gomi = "</p></body></html>"

#Proxy
use_proxy = ENV['ENV_USE_PROXY']
proxy_sv =  ENV['ENV_PROXY'] 
user     =  ENV["ENV_ID"] 
pass     =  ENV["ENV_PASS"] 
proxy = [proxy_sv, user, pass]

 
#def to_myhash(str)
#    str.scan(/(\w+):\s+(\d+)/).map{|k, v| [k.to_sym, v.to_i] }
#end

day = Date.today
#today = day.strftime("%Y%m%d")

days = Array.new
(0..7).each do |d|
  days.push((day+d).strftime("%Y%m%d"))
end

days.each do |today|
  logger.debug(today)

##Loop Start ###

host = 'http://tv.so-net.ne.jp'
url = host + '/chart/23.action?head=' + today + '0000&span=24&chartWidth=950&cellHeight=3&sticky=true&descriptive=true&iepgType=0&buttonType=0 '

html = ""
if use_proxy == "true" then
  html = open(url,{:proxy_http_basic_authentication => proxy})
else
  html = open(url)
end
doc = Nokogiri::HTML(html)

json = "{ \"date\":" + "\"" + today + "\","
json += "\"region\":" + "\"" + "東京" + "\","
json += "\"region_cd\":" + "\"" + "23" + "\","
json += "\"iepgs\" : [ "

catch(:exit) {

test = 0
doc.css('a').each do |item|
  if /^\/iepg.tvpi/ =~ item[:href] then
    logger.debug( host+item[:href])
    ipeg = ""

    if use_proxy == "true" then
      iepg = open(host+item[:href], {:proxy_http_basic_authentication => proxy})
      #test += 1
    else # For Development Environment
      iepg = open(host+item[:href])
    end

    #Delay
    sleep(delay)

    tv_sjis = Nokogiri::HTML.parse(iepg, nil, "Shift_JIS")
    
    tv = tv_sjis.to_s.encode("UTF-8", "Shift_JIS")

    #Jsonに変換
    count = 0
    json += "{"
    tv.each_line do |line|
      count += 1

      str = line.chomp
      if str.index(station) == 0 then
        logger.debug( str[station.length+1..str.length] )
        json += "\"" + station_json + "\":\"" + str[station.length+1..str.length] + "\","
      elsif str.index(station_name) == 0 then
        logger.debug( str[station_name.length+1..str.length])
        json += "\"" + station_name_json + "\":\"" + str[station_name.length+1..str.length] + "\","
      elsif str.index(year) == 0 then
        logger.debug( str[year.length+1..str.length])
        json += "\"" + year_json + "\":\"" + str[year.length+1..str.length] + "\","
      elsif str.index(month) == 0 then
        logger.debug( str[month.length+1..str.length])
        json += "\"" + month_json + "\":\"" + str[month.length+1..str.length] + "\","
      elsif str.index(date) == 0 then
        logger.debug( str[date.length+1..str.length])
        json += "\"" + date_json + "\":\"" + str[date.length+1..str.length] + "\","
      elsif str.index(start_time) == 0 then
        logger.debug( str[start_time.length+1..str.length])
        json += "\"" + start_time_json + "\":\"" + str[start_time.length+1..str.length] + "\","
      elsif str.index(end_time) == 0 then
        logger.debug( str[end_time.length+1..str.length])
        json += "\"" + end_time_json + "\":\"" + str[end_time.length+1..str.length] + "\","
      elsif str.index(title) == 0 then
        logger.debug( str[title.length+1..str.length])
        json += "\"" + title_json + "\":\"" + str[title.length+1..str.length].gsub(/\"/, '”').gsub(/&amp;/, '＆') + "\","
      elsif str.index(subtitle) == 0 then
        logger.debug( str[subtitle.length+1..str.length])
        json += "\"" + subtitle_json + "\":\"" + str[subtitle.length+1..str.length] + "\","
      elsif str.index(performer) == 0 then
        logger.debug( str[performer.length+1..str.length])
        json += "\"" + performer_json + "\":\"" + str[performer.length+1..str.length] + "\","
      elsif str.index(subperformer) == 0 then
        logger.debug( str[subperformer.length+1..str.length])
        json += "\"" + subperformer_json + "\":\"" + str[subperformer.length+1..str.length] + "\","
      elsif str.index(id) == 0 then
        logger.debug( str[id.length+1..str.length])
        json += "\"" + id_json + "\":\"" + str[id.length+1..str.length] + "\","
      elsif str.index(genre) == 0 then
        logger.debug( str[genre.length+1..str.length])
        json += "\"" + genre_json + "\":\"" + str[genre.length+1..str.length] + "\","
      elsif str.index(subgenre) == 0 then
        logger.debug( str[subgenre.length+1..str.length])
        json += "\"" + subgenre_json + "\":\"" + str[subgenre.length+1..str.length] + "\","
      elsif count == tv.each_line.count
        logger.debug( str[0..str.index(gomi)-1])
        json += "\"" + "detail\":" + "\"" + str[0..str.index(gomi)-1].gsub(/\"/, '”').gsub(/\&amp;/, '＆') + "\""
      end
    end
    json += "},"
    throw :exit if test >= 3
  end
end
}

json = json[0..json.length-2]
json += " ] }"

logger.debug("======= JSON Created! =======")
result = JSON.parse(json)
logger.debug("======= JSON Parsed! =======")


#=============================================


    @channel = Channel.new(result)
    @channel.save

end
##Loop End ###

    
    respond_to do |format|
      #if @channel.save
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @channel }
      #else
      #  format.html { render action: 'new' }
      #  format.json { render json: @channel.errors, status: :unprocessable_entity }
      #end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:date, :region, :region_cd, :iepgs)
    end
end
