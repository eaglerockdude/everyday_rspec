FactoryGirl.define do

  factory   :phone do
    association :contact  #create a contact for this phone if one was not created in the build/create
    phone {Faker::PhoneNumber.phone_number}
    #phone "123-456-7890"  in some cases we try out Faker
    factory :home_phone do
      phone_type "home"
    end
    factory :work_phone do
      phone_type "work"
    end
    factory :mobile_phone do
      phone_type "mobile"
    end
  end
end