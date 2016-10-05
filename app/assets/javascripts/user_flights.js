var user_position;


$(document).ready(function(){
	if ("geolocation" in navigator) {
		console.log("geolocation is available!");

		var options = {
			timeout: 7000,
			enableHighAccuracy: true
		};

		navigator.geolocation.getCurrentPosition(onLocation, onError, options);
	} else {
		alert("We do not have geolocation");
	}
});




function onLocation(position){

	console.log(position);
	var latitude = position.coords.latitude;
	var longitude = position.coords.longitude; 
	user_position = {
		latitude : position.coords.latitude,
		longitude : position.coords.longitude
	};
	console.log("FOUND USER ", user_position);
	if (!user_position || !data || !data.airport_position){
		console.log("Missing Data", user_position, data.airport_position);
		return;
	}
	var position_params = {
		origin_position: user_position,
		destination_position: data.airport_position
	}; 
	getTimeEstimate(position_params);
}

function getTimeEstimate(position_params) {
	// var url = `https://maps.googleapis.com/maps/api/distancematrix/json?origins=${position_params.origin_position.latitude},${position_params.origin_position.longitude}&destinations=${position_params.destination_position.latitude},${position_params.destination_position.longitude}&departure_time=${Date.now()}&traffic_model=best_guess&key=AIzaSyDWfU7MX1c2hg5l42fecXZyhAdhyTm4Tt4`
	// var request = $.get(url);
	// request.done = function(data){
	// 	var google_estimate = data.rows[0]['elements'][0]['duration']['value'];
	// 	var total_time_estimate = google_estimate + data.tsa_wait_time;
	// 	$('#wait_time').text(total_time_estimate);
	// };
	// $.ajax({
 //        type: 'GET',
 //        url: 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=25.766057099999998,-80.1960205&destinations=25.79498,-80.27849&departure_time=1474592459116&traffic_model=best_guess&key=AIzaSyDWfU7MX1c2hg5l42fecXZyhAdhyTm4Tt4',
 //        dataType: 'jsonp',
 //        success: function (data) {
 //            console.log(data);
 //        }
 //    });
 	var origin = new google.maps.LatLng(position_params.origin_position.latitude, position_params.origin_position.longitude)
 	var destination = new google.maps.LatLng(position_params.destination_position.latitude, position_params.destination_position.longitude)
	var service = new google.maps.DistanceMatrixService();
	service.getDistanceMatrix({
		origins: [origin],
		destinations: [destination],
		travelMode: 'DRIVING',
		// drivingOptions: { departureTime: Date.now() },
		avoidHighways: true,
		avoidTolls: true,
	},
		handle_google_time_estimate
	);
	return 1;
}

function handle_google_time_estimate(response, status) {
	console.log(response);
	var google_estimate = response.rows[0].elements[0].duration.value;
	var total_time_estimate = ((Math.floor(google_estimate / 60, 0)) + data.tsa_wait_time);

	$('#wait_time').text(total_time_estimate);
}



function onError(err){
	console.log(err);
}


