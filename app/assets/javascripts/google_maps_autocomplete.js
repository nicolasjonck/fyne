function onPlaceChanged() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  var eventAddress = document.getElementById('event_street_address');
  eventAddress.blur();
  eventAddress.value = components.address;

  var eventAddressZipCode = document.getElementById('event_zip_code')
  eventAddressZipCode.value = components.zip_code;

  var eventAddressCity = document.getElementById('event_city')
  eventAddressCity.value = components.city;
  // document.getElementById('event_state').value = components.state;

  if (components.country_code) {
    var selector = '#event_country option[value="' + components.country_code + '"]';
    document.querySelector(selector).selected = true;
  }
}

function getAddressComponents(place) {
  // If you want lat/lng, you can look at:
  // - place.geometry.location.lat()
  // - place.geometry.location.lng()

  if (window.console && typeof console.log === "function") {
    console.log(place);
  }

  var street_number = null;
  var route = null;
  var zip_code = null;
  var city = null;
  var country_code = null;
  for (var i in place.address_components) {
    var component = place.address_components[i];
    for (var j in component.types) {
    var type = component.types[j];
    if (type === 'street_number') {
      street_number = component.long_name;
    } else if (type === 'route') {
      route = component.long_name;
    } else if (type === 'postal_code') {
      zip_code = component.long_name;
    } else if (type === 'locality') {
      city = component.long_name;
    } else if (type === 'postal_town' && city === null) {
      city = component.long_name;
    } else if (type === 'country') {
      country_code = component.short_name;
    }
  }
}

return {
  address: street_number === null ? route : (street_number + ' ' + route),
  zip_code: zip_code,
  city: city,
  country_code: country_code
};
}

document.addEventListener("DOMContentLoaded", function() {
var eventAddress = document.getElementById('event_street_address');

if (eventAddress) {
  var autocomplete = new google.maps.places.Autocomplete(eventAddress, { types: ['geocode'] });
  google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  google.maps.event.addDomListener(eventAddress, 'keydown', function(e) {
    if (e.key === "Enter") {
      e.preventDefault(); // Do not submit the form on Enter.
    }
  });
}
});
