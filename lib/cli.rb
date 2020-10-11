class CLI

    def start
        puts ""
        puts "Welcome! Let's find some makeup."
        prompt_brand
        yes_or_no = gets.chomp.downcase
        while yes_or_no != "yes" && yes_or_no != "no"
            try_again
            yes_or_no = gets.chomp.downcase
        end
        if yes_or_no == "yes"
            arr = []
            search_by_brand(arr)
            prompt
            while @inp != 'exit' do
                while @inp.to_i <= 0 || @inp.to_i > @brand_arr.length
                    choose_a_number
                    @inp = gets.chomp.downcase
                    if @inp == 'exit'
                        break
                    end
                end
                if @inp.to_i > 0 && @inp.to_i <= @brand_arr.length
                    int_input = @inp.to_i - 1
                    @item_number = @brand_arr[int_input]
                    more_info(@item_number)
                    buy_item_brand
                end
            end
        elsif yes_or_no == "no"
            @makeup = Makeup.all
            print_makeup(@makeup)
            prompt
            while @inp != 'exit' do
                while @inp.to_i <= 0 || @inp.to_i > @makeup.length
                    choose_a_number
                    @inp = gets.chomp.downcase
                    if @inp == 'exit'
                        break
                    end
                end
                if @inp.to_i > 0 && @inp.to_i <= @makeup.length
                    int_input = @inp.to_i - 1
                    @item_number = @makeup[int_input]
                    more_info(@item_number)
                    buy_item
                end
            end
        end
        puts ""
        puts "Thanks for using this program"
        puts "Goodbye!"
        puts ""
    end

    def prompt
        puts ""
        puts "Enter in the product number that you would like more information on"
        puts "or type 'exit' to exit this program."
        puts ""
        @inp = gets.chomp.downcase
    end

    def choose_a_number
        puts ""
        puts "Please choose a number in the list above"
        puts "or type 'exit' to exit this program."
        puts ""
    end

    def try_again
        puts ""
        puts "Hmm, I don't think I understand."
        puts "Please enter 'Yes' or 'No'."
        puts ""
    end

    def prompt_brand
        puts ""
        puts "What kind of product are you looking for?"
        puts ""
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
            puts "Please choose a brand from the list above."
            puts ""
            @brand = gets.chomp.downcase
        end
        brand_list
    end

    def brand_list
        @brand_arr = Makeup.find_by_brand(@brand)
        puts ""
        puts "These are all of the #{@product} products we have by #{@brand}:"
        @brand_arr.each_with_index do |b, i|
            puts "#{i+1}. #{b.name}"
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
            puts "Other people rated this product #{info.rating} out of 5 stars!"
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

    def buy_item_brand
        puts "Would you like to buy this product?"
        puts ""
        inp = gets.chomp.downcase
        while inp != "yes" && inp != "no"
            try_again
            inp = gets.chomp.downcase
        end
        if inp == "yes"
            puts ""
            puts "You can buy this product at this website: #{@item_number.website}."
            puts ""
            buy_item_decision
            @inp = gets.chomp.downcase
            brand_condition(@inp)
        elsif inp == "no"
            buy_item_decision
            @inp = gets.chomp.downcase
            brand_condition(@inp)
        end
    end

    def buy_item
        puts "Would you like to buy this product?"
        puts ""
        inp = gets.chomp.downcase
        while inp != "yes" && inp != "no"
            try_again
            inp = gets.chomp.downcase
        end
        if inp == "yes"
            puts ""
            puts "You can buy this product at this website: #{@item_number.website}."
            puts ""
            buy_item_decision
            @inp = gets.chomp.downcase
            condition(@inp)
        elsif inp == "no"
            buy_item_decision
            @inp = gets.chomp.downcase
            condition(@inp)
        end
    end


    def buy_item_decision
        puts ""
        puts "type 'list' to back to the list"
        puts "or type 'exit' to exit the program"
        puts ""
    end

    def brand_condition(inp)
        if inp == "list"
            brand_list
            prompt
        elsif inp == "exit"
        end
    end

    def condition(inp)
        if inp == "list"
            print_makeup(@makeup)
            prompt
        elsif inp == "exit"
        end
    end
end