console.log('Hello World from categories')


const categoryField = document.getElementById('event_category')
const subcategoryField = document.getElementById('event_subcategory')

const subcats_hash = {};
subcats_hash["Art & Culture"] = ["Theatre", "Literature"];
subcats_hash["Music"] = ["Alternative", "Blues", "Classical", "Dance", "Electro", "Hip-hop/Rap", "Jazz", "Metal", "For children", "World music", "Pop", "Raggae", "Rock", "Other genre"];
subcats_hash["Films & Series"] = ["Action", "Animation", "Biography", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "History", "Horror", "Musical", "Romance", "Sport", "War", "Western"];
subcats_hash["Sports"] = ["Football", "Rugby", "Tennis", "Formula 1", "Auto/moto", "Basket", "Handball", "Golf", "Cycle", "Winter sports", "Athletism", "Swimming", "Volley-ball", "Other sports"];
subcats_hash["Games"] = ["Games"];
subcats_hash["Wellness & Health"] = ["Dancing", "Fitness", "Health"];
subcats_hash["Spirituality"] = ["Spirituality"];
subcats_hash["Non-profit"] = ["Non-profit"];
subcats_hash["Tasting & Restauration"] = ["Food tasting", "Drink tasting"];
subcats_hash["Crafting"] = ["Crafting (General)", "Gardening", "Home"];
subcats_hash["Party"] = ["Party"];
subcats_hash["Business"] = ["Networking", "Shopping", "Conference"];
subcats_hash["Politics"] = ["Politics"];
subcats_hash["Other"] = ["Other"];


categoryField.addEventListener("change",(event) => {
  let categorySelected = categoryField.value;
  let subcategories_matching = subcats_hash[categorySelected];

  let subcat_options = subcategoryField.querySelectorAll("option");

  subcategoryField.innerHTML = ""

  subcategories_matching.forEach((subcategory) => {
    subcategoryField.insertAdjacentHTML("beforeend", `<option value="${subcategory}">${subcategory}</option>`);
  });

});


