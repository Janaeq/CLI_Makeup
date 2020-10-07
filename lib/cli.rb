# handle interactions with user
# contain all gets and puts
# control the flow of our program

class CLI

    def start
        puts ""
        puts "Find Makeup for You!"
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
         
    end

    def print_makeup(mu)
        puts""
        puts "Here is a list of all the #{@product} we have:"
        puts ""
        mu.each_with_index do | m, i|
            puts "#{i+1}. #{m.brand.split(/ |\_|\-/).map(&:capitalize).join(" ")} #{m.name}"
            # binding.pry
        end
    end
end