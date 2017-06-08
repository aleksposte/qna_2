require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }


  describe 'author_of?' do
    let(:user) { create(:user) }
    let(:user1) { create(:user) }
    let(:question) { create(:question, user: user) }

    it 'should return true if user is an owner of a question' do
      expect(user.author_of? question).to eq true
    end

    it 'should return false if user is not an owner of a question' do
      expect(user1.author_of? question).to eq false
    end
  end

end
