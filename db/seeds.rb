# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

User.create!(name:  "Mr Admin",
             email: "john_m_30@hotmail.com",
             password:              "280767",
             password_confirmation: "280767",
             admin: true
             #activated: true,
             #activated_at: Time.zone.now
             )



# Book reviews
=begin
user = User.find_by(name: "Mr Admin")
BookReview.create!(user_id: user.id,
            title: "The Best Book",
            author: "John McA",
            description: "This book describes everything and I have to make it at least 100 characters long for it to work
            and then try again to get the full letter count.",
            opinion: "This is the best book in the world and I have to make it at least 100 characters long for it to work
            and then try again to get the full letter count.")
=end


