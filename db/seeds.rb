require 'open-uri'
require 'json'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ingredients = JSON.parse(open("http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list").read)

ingredients["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end

cocktails = JSON.parse(open("http://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail").read)

cocktails["drinks"].each do |cocktail|
  p cocktail
  cid = cocktail["idDrink"]
  imageurl = "http://" + cocktail["strDrinkThumb"] if cocktail["strDrinkThumb"] != nil
  cocktail = Cocktail.create(name: cocktail["strDrink"], imageurl: imageurl)
  detailsurl = "http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{cid}"
  cocktail_details = JSON.parse(open(detailsurl).read)

  (1..15).to_a.map {|num| ["strIngredient" + num.to_s, "strMeasure" + num.to_s] }.each do |payload|
    unless payload[0] == ""
     Dose.create(description: cocktail_details["drinks"][0][payload[1]], cocktail: cocktail, ingredient: Ingredient.where(name: cocktail_details["drinks"][0][payload[0]]).first)
   end
 end

end

# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")
