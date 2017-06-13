FactoryGirl.define do
  sequence :body do |n|
    "MyText #{n}"
  end

  factory :answer, class: 'Answer' do
    question
    body
    user
  end

  factory :invalid_answer, class: 'Answer' do
    question
    body nil
    user
  end
end
