require('pry')
require_relative("./models/property")

Property.delete_all()

house1 = Property.new({
  "address" => "2/1 29 Hope Street Glasgow",
  "value" => 135000,
  "bedrooms" => 2,
  "build" => "flat"
  })

  house2 = Property.new({
    "address" => "3/2 291 Dumbarton Road Glasgow",
    "value" => 105000,
    "bedrooms" => 1,
    "build" => "flat"
    })

house1.save()
house2.save()

house1.bedrooms = 3
house1.update()

found1 = Property.find_by_id(20)
found2 = Property.find_by_address("3/2 291 Dumbarton Road Glasgow")

all_houses = Property.all()

binding.pry
nil
