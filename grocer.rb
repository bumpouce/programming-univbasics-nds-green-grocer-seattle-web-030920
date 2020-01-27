def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do
    if collection[i][:item] == name
      item_info = collection[i]
    end
    i += 1
  end
  item_info
end

def consolidate_cart(cart)
  
  i = 0 
  sorted_cart = []
  
  while i < cart.length do
    item_name = cart[i][:item]
    if !find_item_by_name_in_collection(item_name, sorted_cart)
      cart[i][:count] = 1
      sorted_cart << cart[i]
    else
      j = 0
      while j < sorted_cart.length do
        if find_item_by_name_in_collection(item_name, sorted_cart)
          sorted_cart[j][:count] += 1
        end
        j += 1 
      end
    end
    i += 1
  end
  
  sorted_cart
end

def apply_coupons(cart, coupons)

  #ensure cart is sorted
  cart = consolidate_cart(cart)
  pp "Cart is sorted."
  
  i = 0
  
  #for each coupon, look for the item in the cart
  while i < coupons.length do
    search_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    pp "Found item: #{search_item}"
    
    #if it's not found, move to next coupon
    if !search_item
      pp "Coupon for #{coupon[i][:item]} cannot be applied. None found in cart."
    end

    #if found, compare number in cart with number on coupon
    #case 1: number in cart < coupon, coupon invalid
    #case 2: number in cart == coupon, apply coupon
    #case 3: number in cart

    if search_item[:count] < coupons[i][:num]
        pp "Not enough #{coupons[i][:item]}s to apply coupon."
    end
    if search_item[:count] == coupons[i][:num]
        pp "The cart contains #{coupons[i][:num]} #{coupons[i][:item]}s.  Coupon applies to all."
    end
    if  search_item[:count] > coupons[i][:num]
        pp "The cart contains #{search_item[i][:count]} #{coupons[i][:item]}s.  Coupon applies to #{coupons[i][:num]}."
    end
  
    i += 1 
  end

end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
