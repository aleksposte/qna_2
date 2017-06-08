FactoryGirl.define do
  sequence :body do |n|
    "MyText #{n}"
  end
  factory :answer do
    question
    body
    # body 'MyText'
    user
  end

end
