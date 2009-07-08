Factory.define :user do |f|
  f.email { Faker::Internet.email }
  f.login { Faker::Internet.user_name }
  f.password { 'test1234'}
  f.password_confirmation { 'test1234'}
  f.profile { Factory(:profile) }
end
