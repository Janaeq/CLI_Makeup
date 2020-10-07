# going to keep track of makeup
# turn responses into objects
# save all makeup created

class Makeup
    attr_accessor :name, :brand, :price, :colors

    @@all = []

    def initialize(name:, brand:, price:)
        @name = name
        @brand = brand 
        @price = price
        @colors = []
        @@all << self
        
    end

    def self.all
        @@all
    end
end