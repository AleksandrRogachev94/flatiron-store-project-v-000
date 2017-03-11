10.times do
  Item.create(
    title: Faker::Commerce.product_name,
    inventory: Faker::Number.number(2),
    price: Faker::Number.number(4)
  )
  Category.create(title: Faker::Commerce.department)
end

counter = 1
Item.all.each do |item|
  item.category_id = counter
  item.save
  counter += 1
end

user = User.create(email: "admin@mail.ru", password: "27121994", password_confirmation: "27121994")

c1 = Cart.create
#user.update(current_cart: c1)
c1.line_items.create(item: Item.all[1], quantity: 3)
c1.line_items.create(item: Item.all[2], quantity: 2)
c1.line_items.create(item: Item.all[3], quantity: 1)
