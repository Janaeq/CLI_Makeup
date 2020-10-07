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
        item_number = gets.chomp.to_i - 1
        @item_instance_number = makeup[item_number]
        more_info(@item_instance_number)
        # puts ""
        # puts "Would you like to buy this product?"
        # puts ""
        # purchase = gets.chomp.downcase
        buy_item 
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
        puts ""
        puts "#{info.brand.split(/ |\_|\-/).map(&:capitalize).join(" ")} - #{info.name}"
        puts ""
        puts "Details:"
        puts "#{info.description}"
        puts ""
        if info.rating == nil
            puts "Sorry! There are no ratings for this product yet."
        else
            puts "Other people gave this product #{info.rating} out of 5 stars!"
        end
        puts ""
        if info.price.to_i == 0
            puts "This product is FREE!"
        elsif info.price.to_i <= 5
            puts "This product costs #{info.price}. What a steal!"
        else
            puts "This product costs $#{info.price}."
        end
        puts ""
    end

    def buy_item
        puts ""
        puts "Would you like to buy this product?"
        puts ""
        inp = gets.chomp.downcase

        if inp != "yes" || inp != "no"
            puts ""
            puts "I'm not sure what you mean. Please enter 'Yes' or 'No'."
            puts ""
        elsif inp == "yes"
            if @item_instance_number.website == nil
                puts "Sorry, this item is discontinued!"
            else
                puts "You can buy this product at this website: #{@item_instance_number.website}"
            end
        else inp == "no"
            self.start
        end
        binding.pry
    end
end