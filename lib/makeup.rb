class Makeup
    attr_accessor :name, :brand, :price, :colors, :description, :website, :rating, :product

    @@all = []
    @@brand = []
    @@available_products = ["blush", "bronzer", "eyebrow", "eyeliner", "eyeshadow", "foundation", "lip liner", "lipstick", "mascara", "nail polish"]

    def initialize(name:, brand:, price:, description:, website:, rating:, product:)
        @name = name
        @price = price
        @brand = brand
        @colors = []
        @description = description
        @website = website
        @rating = rating
        @product = product
        @@all << self
        @@brand << brand
    end
    
    def self.all
        @@all
    end

    def self.available_brands 
        @@brand.uniq.compact
    end

    def self.available_products
        @@available_products
    end

    def self.find_by_brand(brand) 
        @@all.select {|m| m.brand == brand}
    end
end