require 'random_data'
require 'faker'

  5.times do
    User.create!(
      # email:    RandomData.random_email,
      # password: RandomData.random_sentence
      email: Faker::Internet.unique.safe_email,
      password: Faker::Internet.password(8,16)

   )
  end

  # Create an admin user
  admin = User.create!(
    email:    'admin@asdf.com',
    password: 'asdfasdf',
    role:     'admin'
  )

  # Create a member
  standard = User.create!(
    email:    'standard@asdf.com',
    password: 'asdfasdf',
    role: 'standard'
  )

  #create premium
  premium = User.create!(
    email:    'premium@asdf.com',
    password: 'asdfasdf',
    role:     'premium'
  )


  users = User.all

  #Create WIKIS
  50.times do |i|
    wiki = Wiki.create!(
      user:   users.sample,
      title:  "Wiki title #{i} #{Faker::Lorem.sentence(2)}",
      body: "Wiki body #{i} #{Faker::Lorem.paragraph(5)}",
      private: false
    )
  end
  wikis = Wiki.all


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} posts created"