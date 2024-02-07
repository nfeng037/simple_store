require "csv"

# Clean the products and categories tables
Product.destroy_all
Category.destroy_all

# Loop through the rows of the CSV file
csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true, encoding: 'iso-8859-1')

products.each do |product|
  category_name = product['category']
  category = Category.find_or_create_by(name: category_name)

  product = Product.new(
    title: product['name'],
    price: product['price'],
    description: product['description'],
    stock_quantity: product['stock quantity'],
    category: category
  )

  product.save!
end
