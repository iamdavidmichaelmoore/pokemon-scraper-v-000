require 'pry'

class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  @@all = []

  def initialize(id:, name:, type:, hp: 60, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.save(name:, type:, hp: 60, db:)
    @db.execute("INSERT INTO pokemon (name, type, hp) VALUES (?,?,?)", name, type, hp)
  end

  def self.find(id, database)
    result = database.execute("SELECT * FROM pokemon WHERE pokemon.id = ?", id)
    data = result.flatten
    pokemon = self.new(id: data[0], name: data[1], type: data[2], hp: data[3], db: database)
    pokemon
    binding.pry
  end

  def alter_hp(hp, database)
    database.execute("UPDATE pokemon SET hp = ? WHERE name = ?", hp, self.name)
  end

end
