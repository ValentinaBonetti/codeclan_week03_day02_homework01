require("pg")


class Property

  attr_accessor :address, :value, :bedrooms, :build
  attr_reader :id

  def initialize(options)
    @address = options["address"]
    @value = options["value"]
    @bedrooms = options["bedrooms"]
    @build = options["build"]
    @id = options["id"].to_i if options["id"]
  end

  def save()
    db = PG.connect({ dbname: "property_tracker", host: "localhost"})
    sql = "INSERT INTO houses (address,value,bedrooms,build)
           VALUES ($1,$2,$3,$4)
           RETURNING *"
    values = [@address,@value,@bedrooms,@build]
    db.prepare("save",sql)
    @id = db.exec_prepared("save",values)[0]["id"].to_i
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "DELETE FROM houses WHERE id = $1"
    values = [@id]
    db.prepare("delete_one",sql)
    db.exec_prepared("delete_one",values)
    db.close()
  end


  def update()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "UPDATE houses SET (address,value,bedrooms,build) = ($1,$2,$3,$4)
           WHERE id = $5"
    values = [@address,@value,@bedrooms,@build,@id]
    db.prepare("update",sql)
    db.exec_prepared("update",values)
    db.close()
  end



    # class methods

  def Property.find_by_id(id)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM houses WHERE id = $1"
    values = [id]
    db.prepare("find_by_id",sql)
    house = db.exec_prepared("find_by_id",values)
    db.close()
    return house.map{|hash_house| Property.new(hash_house)}
  end


  def Property.find_by_address(address)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM houses WHERE address = $1"
    values = [address]
    db.prepare("find_by_address",sql)
    house = db.exec_prepared("find_by_address",values)
    db.close()
    return house.map{|hash_house| Property.new(hash_house)}
  end


  def Property.all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM houses"
    db.prepare("all",sql)
    list_of_houses = db.exec_prepared("all")
    db.close()
    return list_of_houses.map{|hash| Property.new(hash)}
  end

  def Property.delete_all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "DELETE FROM houses"
    db.prepare("delete_all",sql)
    db.exec_prepared("delete_all")
    db.close()
  end

end
