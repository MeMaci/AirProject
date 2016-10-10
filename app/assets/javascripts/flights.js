
// var data = {
// 		airport_position: {
// 			latitude: <%= @airport_position[:airport_latitude]%>,
// 			longitude: <%= @airport_position[:airport_longitude]%>
// 		},
// 		tsa_wait_time : <%= @wait_time %>
// 	};
// 	console.log("Airpot pos = ", data)


$(document).ready(function() {
  $.simpleWeather({
    location: data.destination_airport_position.latitude+','+data.destination_airport_position.longitude,
    woeid: '',
    unit: 'f',
    success: function(weather) {
      html = '<h2><i class="weather icon-'+weather.code+'"></i> '+weather.temp+'&deg;'+weather.units.temp+'</h2>';
      html += '<ul><li>'+weather.city+', '+weather.region+'</li>';
      html += '<li class="currently">'+weather.currently+'</li>';
      html += '<li>'+weather.wind.direction+' '+weather.wind.speed+' '+weather.units.speed+'</li></ul>';
  
      $("#weather").html(html);
    },
    error: function(error) {
      $("#weather").html('<p>'+error+'</p>');
    }
  });
});