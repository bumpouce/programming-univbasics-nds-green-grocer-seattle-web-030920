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
        if sorted_cart[j][:item] == item_name 
          sorted_cart[j][:count] += 1
          j = sorted_cart.length
        end
        j += 1 
      end
    end
    i += 1
  end
  
  sorted_cart
end

def apply_coupons(cart, coupons)

  i = 0
  if coupons.length == 0
    return cart
  end  
  
  #for each coupon, look for the item in the cart
  while i < coupons.length do
    search_item = find_item_by_name_in_collection(coupons[i][:item], cart)

    #if it's not found, move to next coupon
    if !search_item
      pp "Coupon for #{coupon[i][:item]} cannot be applied. None found in cart."

    else       
      #update cart item count
        
      j = 0 
      
      while j < cart.length do
        if cart[j][:item] == search_item[:item] 
          clearance_flag = cart[j][:clearance]
          coupon_count
          if cart[j][:count] > coupons[i][:num]
            cart[j][:count] -= coupons[i][:num]
          elsif cart[j][:count] == coupons[i][:num]
            cart[j][:count] = 0
          else

          end 
          
        end
        j += 1 
      end
      
      cart << {:item => coupons[i][:item] + " W/COUPON", :price => coupons[i][:cost] / coupons[i][:num], :clearance => clearance_flag, :count => coupons[i][:num]}

      end
      i += 1 
    end
  cart
end

def apply_clearance(cart)
  i = 0 

  while i < cart.length do
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] * 0.8).round(3)
    end
    i += 1 
  end
  cart
end

def checkout(cart, coupons)
  cart_total = 0 
  
  pp "Initial cart: #{cart}"
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
#  pp "Added coupons: #{cart}"
  cart = apply_clearance (cart)
#  pp "Applied clearance prices: #{cart}"
  
  i = 0 
  while i < cart.length do
    cart_total += cart[i][:price] * cart[i][:count]
    pp "#{cart[i][:count]} #{cart[i][:item]}s for #{cart[i][:price]}"
    i += 1 
  end
  cart_total
end
