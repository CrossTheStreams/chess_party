FactoryBot.define do
  factory :user do
    email "darthvader@empire.com"
    password "secret_password"
  end
  factory :opponent do
    email "lukeskywalker@rebels.com"
    password "secret_password"
  end
end
