# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Generate a bunch of additional users.
99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  country = Faker::Address.country
  email = "example-#{n + 1}@email.com"
  mobile = Faker::PhoneNumber.cell_phone
  is_admin = Faker::Boolean.boolean

  User.create(first_name: first_name,
               last_name: last_name,
               country: country,
               email: email,
               mobile: mobile,
               is_admin: is_admin,
               password: 'password',
               password_confirmation: 'password')
end
