Factory.define :profile do |f|
  f.name { Faker::Name.first_name }
end
