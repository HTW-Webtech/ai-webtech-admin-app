FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "s0000#{n}@htw-berlin.de" }
    name    'Max Mustermann'
    ssh_key 'AASAD…'
    password 'HAW!@!AAS'
  end
end
