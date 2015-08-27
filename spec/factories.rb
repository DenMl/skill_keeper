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

  factory :skill do
  	sequence(:name) { |n| "Skill #{n}" }
  	sequence(:description) {|n| "Skill #{n} short description."}
  end

  factory :candidate do
    sequence(:first_name) { |n| "First Name #{n}" }
    sequence(:last_name) {|n| "Last Name #{n}"}
    sequence(:patronymic) {|n| "Patronymic #{n}"}
  end

  factory :skill_group do
    sequence(:name) { |n| "Skill group #{n}" }
    sequence(:description) {|n| "Skill group #{n} short description."}
  end

end