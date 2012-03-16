namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Homer Simpson",
                 email: "example@example.com",
                 password: "secret",
                 password_confirmation: "secret")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   admin: false)
    end
  end
end
