FactoryGirl.define do
  # This is how to define a user factory that always produces
  # the same user. Replaced by user sequence.
  # factory :user do
  #   name "The Fat One"
  #   email "tfo@cryptid.ribs"
  #   password "cupsrule"
  #   password_confirmation "cupsrule"
  # end
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      # Now calls to FactoryGirl.create :admin will make the above
      # user as an admin.
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
