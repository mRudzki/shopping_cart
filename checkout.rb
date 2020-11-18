class Checkout
    # promotional_rules = {'discount_min_price': 60, 'discount_percentage': 10, 'item_reduced_price_ids': ['001'],
    # 'item_reduced_price_amounts': [2],'item_reduced_price_costs': [8.50]}

    # Items = {'001'=> {'name' => 'Red Scarf', 'price' => 9.25}, '002' => {'name' => 'Silver cufflinks', 'price' => 45.00},
    # '003' => {'name' => 'Silk Dress', 'price' => 19.95}}
    
    def initialize(promotional_rules)
        @products = Hash.new
        @discount_min_price = promotional_rules[:discount_min_price]
        @discount_percentage = promotional_rules[:discount_percentage]
        @item_reduced_price_ids = promotional_rules[:item_reduced_price_ids]
        @item_reduced_price_amounts = promotional_rules[:item_reduced_price_amounts]
        @item_reduced_price_costs = promotional_rules[:item_reduced_price_costs]
    end

    def scan(item)
        @products[item].nil? ? @products[item] = 1 : @products[item] += 1
    end

    def total
        sum = 0
        @products.each do |product_id, amount|
            index_if_reduced = @item_reduced_price_ids.index(product_id)
            if index_if_reduced.nil?
                sum += amount * Items[product_id]['price']
            else
                if amount >= @item_reduced_price_amounts[index_if_reduced]
                    sum += amount * @item_reduced_price_costs[index_if_reduced]
                else
                    sum += amount * Items[product_id]['price']
                end
            end
        end
        sum >= @discount_min_price ? sum = (sum * (1 - @discount_percentage/100.0)) : sum
        sum.round(2)
    end
end