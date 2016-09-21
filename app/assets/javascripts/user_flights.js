
var p;

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
	p = position;
	var latitude = position.coords.latitude;
	var longitude = position.coords.longitude; 
	//DELETE THE LATITUDE AND LONGITUDE and PLUG IN VARIABLES WITH STRING INTERPULATION
	var	url=`https://maps.googleapis.com/maps/api/staticmap?center=${latitude},${longitude}&zoom=13&size=400x300`
	$("#map").prop("src",url);
}

function onError(err){
	console.log(err);
}