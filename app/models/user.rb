class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  def author_of?(value)
    # self.id == value.user_id
    value.user_id == id if value.respond_to?(:user_id)
  end
end
#
# def author_of?(model)
#   model.user_id == id if model.respond_to?(:user_id)
# end