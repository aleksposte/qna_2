FactoryGirl.define do
  factory :attachment do
    # file "MyString"
    file Rack::Test::UploadedFile.new(File.open("#{Rails.root}/spec/spec_helper.rb"))
  end
end
