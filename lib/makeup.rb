# going to keep track of makeup
# turn responses into objects
# save all makeup created

class Makeup
    attr_accessor :name, :brand, :price

    @@all = []

    def initialize(name:, brand:, price:)
        @name = name
        @brand = brand
        @price = price
        @@all << self
    end

    def self.all
        @@all
    end
end