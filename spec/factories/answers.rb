FactoryGirl.define do

  factory :answer do
    question
    body 'MyText'
    user
  end

end
