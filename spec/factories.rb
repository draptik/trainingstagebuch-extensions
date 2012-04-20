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

    # factory :sport do
    #   name "Sky Diving"
    #   users
    # end


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
