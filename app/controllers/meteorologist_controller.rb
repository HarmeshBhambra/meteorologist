require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

    parsed_data = JSON.parse(open(url).read)

    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url_w = "https://api.forecast.io/forecast/86c6c7aae6f273558dd4fd553ba2931b/#{@lat},#{@lng}"

    parsed_data_w = JSON.parse(open(url_w).read)

    @current_temperature = parsed_data_w["currently"]["temperature"]

    @current_summary = parsed_data_w["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_w["hourly"]["data"][1]["summary"]

    @summary_of_next_several_hours = parsed_data_w["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_w["daily"]["summary"]

    # var map;
    # function initMap() {
    #     map = new google.maps.Map(document.getElementById('map'), {
    #     center: {lat: -34.397, lng: 150.644},
    #     zoom: 8
    #     });
    # }

    render("street_to_weather.html.erb")
  end
end
