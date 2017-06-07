require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'check if user is an owner of a thing ' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it 'should return true if user is an owner of a question' do
      expect(user.author_of?(question)).to eq true
    end

    it 'should return false if user is not an owner of a question' do
      expect(other_user.author_of?(question)).to eq false
    end

  end

end
