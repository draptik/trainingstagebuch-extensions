FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  # Many to many....
  factory :sport do
    name "Sky Diving"
    comment "Crazy"
    lastchange DateTime.now
    users
  end
    
  # Many to many....
  factory :route do
    name "Home Route"
    route_id 42
    km 42.00
    #users
  end

  # One to many....
  factory :material do
    material_id "123"
    name "material1" 
    status ""
    count 1
    duration 12.23
    distance_km 100.00
    lastchange Time.now
    user
  end

end
