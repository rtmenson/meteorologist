require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    @geo_url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address.gsub(" ","+")
    @geo_data = JSON.parse(open(@geo_url).read)
    @lat = @geo_data["results"][0]["geometry"]["location"]["lat"]
    @lng = @geo_data["results"][0]["geometry"]["location"]["lng"]
    @forecast_url = "https://api.darksky.net/forecast/7eeadd671a82bbea4386a0370b8340f2/"+ @lat.to_s+","+@lng.to_s
    @forecast_data = JSON.parse(open(@forecast_url).read)


    @current_temperature =  @forecast_data["currently"]["temperature"]

    @current_summary =  @forecast_data["currently"]["summary"]

    @summary_of_next_sixty_minutes =  @forecast_data["minutely"]["summary"]

    @summary_of_next_several_hours = @forecast_data["hourly"]["summary"]

    @summary_of_next_several_days = @forecast_data["daily"]["summary"]


    render("meteorologist/street_to_weather.html.erb")
  end

end
