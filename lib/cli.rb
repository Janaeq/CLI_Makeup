# handle interactions with user
# contain all gets and puts
# control the flow of our program

class CLI

    def start
        puts ""
        puts "Welcome! Let's find some makeup."
        puts ""
        puts "What kind of product are you looking for?"
        puts ""
        # below saves the user's input as a variable. Make it an instance variable because you will be using it in other methods
        @product = gets.chomp.downcase
        puts ""
        API.fetch_makeup(@product)
        puts ""
        makeup = Makeup.all
        print_makeup(makeup)
        puts ""
        puts "Enter in the product number that you would like more information on."
        puts ""
        @item_number = gets.chomp.to_i - 1
        more_info(makeup[@item_number])
        # binding.pry
    end

    def print_makeup(mu)
        puts""
        puts "Here is a list of all the #{@product} we have:"
        puts ""
        mu.each_with_index do | m, i|
            if m.brand 
            puts "#{i+1}. #{m.brand.split(/ |\_|\-/).map(&:capitalize).join(" ")} - #{m.name}"
            else 
                puts "#{i+1}. #{m.name}"
            end
            # binding.pry
        end
    end

    def more_info(info)
        puts ""
        puts "#{info.brand}"
        puts "#{info.name}"
        # puts "#{info.description}"
        # puts ""
        # binding.pry
    end
end