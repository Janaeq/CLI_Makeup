# handle interactions with user
# contain all gets and puts
# control the flow of our program

class CLI

    @@cart = []

    def start
        puts ""
        puts "Welcome! Let's find some makeup."
        puts ""
        puts "What kind of product are you looking for?"
        puts ""
        # below saves the user's input as a variable. Make it an instance variable because it will be used in other methods
        @product = gets.chomp.downcase
        # product parameters - Makeup.available_products
        while Makeup.available_products.include?(@product) == false
            puts ""
            puts "Hmm, it doesn't look like we carry that product."
            puts ""
            puts "Here is a list of items we carry:"
            puts Makeup.available_products.join(", ")
            puts ""
            puts "Please enter in the name of the product you would like to search."
            puts ""
            @product = gets.chomp.downcase
        end
        API.fetch_makeup(@product)
        puts "" 
        puts "Would you like to search #{@product} products by brand?"
        puts ""
        yes_or_no = gets.chomp.downcase
        while yes_or_no != "yes" && yes_or_no != "no"
            puts ""
            puts "Hmm, I don't think I understand."
            puts "Would you like to search #{@product} products by brand?"
            puts "Please enter 'Yes' or 'No'."
            puts ""
            yes_or_no = gets.chomp.downcase
        end
        if yes_or_no == "yes"
            arr = []
            search_by_brand(arr)
            puts ""
            puts "Enter in the product number that you would like more information on, or type 'exit' to exit this program."
            puts ""
            inp = gets.chomp.downcase
            while inp != 'exit' do
                # what do I do if the user inputs something other than a valid number or "exit"?
                int_input = inp.to_i - 1
                @item_number = @brand_arr[int_input]
                more_info(@item_number)
                buy_item
            end
        else
            makeup = Makeup.all
            print_makeup(makeup)
            puts ""
            puts "Enter in the product number that you would like more information on, or type 'exit' to exit this program."
            puts ""
            inp = gets.chomp.downcase
            while inp != 'exit' do
                # what do I do if the user inputs something other than a valid number or "exit"?
                int_input = inp.to_i - 1
                @item_number = makeup[int_input]
                more_info(@item_number)
                #difficulty here
                buy_item
            end
        end
    end

    def print_makeup(m) # m is an array of all makeup instances (Makeup.all)
        puts""
        puts "Here is a list of all the #{@product} we have:"
        puts ""
        m.each_with_index do |m, i| # m is one makeup instance. i is that instances position in the array Makeup.all
            # if the instance has a brand, display the number associated to that instance, the brand - name
            if m.brand 
            puts "#{i+1}. #{m.brand.split(/ |\_|\-/).map(&:capitalize).join(" ")} - #{m.name}"
            else 
                # if the instance does not have a brand, put just the number and the name
                puts "#{i+1}. #{m.name}"
            end
        end
    end

    def search_by_brand(b)
        puts ""
        puts "Here is a list of #{@product} brands we carry:"
        puts Makeup.available_brands
        puts ""
        puts "Please choose a brand from the list above."
        puts ""
        @brand = gets.chomp.downcase
        while Makeup.available_brands.include?(@brand) == false
            puts ""
            puts "Sorry, we don't carry that brand."
            puts ""
            puts "Here is a list of #{@product} brands we carry:"
            puts Makeup.available_brands
            puts ""
            puts "Please choose a brand from the list above."
            puts ""
            @brand = gets.chomp.downcase
        end
        @brand_arr = Makeup.find_by_brand(@brand) 
        puts ""
        puts "These are all of the #{@product} products we have by #{@brand}:"
        @brand_arr.each_with_index do |b, i|
            puts "#{i+1}. #{b.name}"
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
        puts "Colors:"
        info.colors.each do |color|
            puts color
        end
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
#
    def buy_item
        puts "Would you like to buy this product?"
        puts ""
        inp = gets.chomp.downcase
        while inp != "yes" && inp != "no"
            puts ""
            puts "I'm not sure what you mean. Please enter 'Yes' or 'No'."
            puts ""
            inp = gets.chomp.downcase
        end
        if inp == "yes"
            puts ""
            puts "You can buy this product at this website: #{@item_number.website}."
            puts ""
        elsif inp == "no"
            puts ""
            puts "Would you like to search for another product?"
            puts ""
            decision = gets.chomp.downcase
            while decision != "yes" && decision != "no"
                puts ""
                puts "I'm not sure what you mean."
                puts "Would you like to search for another product? Please enter 'Yes' or 'No'"
                puts ""
                decision = gets.chomp.downcase
            end
            if decision == "no"
                puts "The decision was no"
                # self.exit
                # help me
            elsif decision == "yes"
                puts "The decision was yes"
                # self.ask_question
            end
            
        end
    end
end