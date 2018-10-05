class User < ApplicationRecord
  belongs_to :branch
  has_many :accounts, dependent: :destroy
  has_many :loans
  validates :name,:father_name,:mother_name,:age,:address,:contact_no,presence: true
  validates :contact_no, length: {is: 10}, numericality: {only_integer: true}
  validate :age_vaild
  private
  def age_vaild
  	if self.age <= 0
      errors.add(:age,"age should be greater than 0")
    end  
  end
end
