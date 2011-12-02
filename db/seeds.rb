# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

admin = User.create( :name => "Admin", :login => "admin", :password => "admin", :password_confirmation => "admin", :email => "admin@admin.com", :admin => true )
blah = User.create( :name => "Blah", :login => "blah", :password => "blah", :password_confirmation => "blah", :email => "admin@admin.com", :admin => true )
#Preference.create( :user => admin )

Contact.create(:name => "Habib Asseiss Neto", :email => "habibasseiss@gmail.com", :user => admin)
Contact.create(:name => "Youssif Domingos", :email => "youssifdomingos@gmail.com", :user => admin)
Contact.create(:name => "Ricardo Assis Domingos", :email => "ricardodomingos55@hotmail.com", :user => admin)
Contact.create(:name => "Samuel Benjoino Ferraz", :email => "samuelbferraz@gmail.com", :user => admin)
Contact.create(:name => "Ana Beatriz", :user => admin)
Contact.create(:name => "Sílvia da Silva", :user => admin)
