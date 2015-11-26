FactoryGirl.define do
  factory :app do
    name { AppName.generate_unique }
    association :user
  end
end
