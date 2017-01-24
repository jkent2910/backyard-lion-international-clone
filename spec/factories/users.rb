FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@gmail.com"
  end

  factory :user do |u|
    u.email
    u.password 'password'
    u.password_confirmation 'password'
    u.user_type 2
  end

  factory :devan, :parent => :user do |d|
    d.email 'devan@gmail.com'
    d.user_type 2
  end
end
