document.addEventListener('DOMContentLoaded', function () {
  const inpu_address = document.getElementById("address");
  const inpu_place_name = document.getElementById("place_name");


  // const autocomplete = new google.maps.places.Autocomplete(inpu_place_name);
    const autocomplete = new google.maps.places.Autocomplete(inpu_place_name);
  autocomplete.setComponentRestrictions({
    country: ["ja"],
  });

  // 場所名のオートコンプリートが選択されたとき
  autocomplete.addListener('place_changed', function() {
    const place = autocomplete.getPlace();
    inpu_place_name.value = place.name;
    inpu_address.value = place.formatted_address;
    });
    inpu_place_name.dataset.autocompleteInitialized = "true";
});

