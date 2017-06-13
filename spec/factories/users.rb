FactoryGirl.define do
  # Создаем уникальнык значения для почт пользователей
  sequence :email do |n|
    "user#{n}@test.com"
  end
  # Вызываем почту для использования
  factory :user do
    email
    password "1234567"
  end
end
