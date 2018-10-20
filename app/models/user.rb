# frozen_string_literal: true

# Description/Explanation of Person class
class User < ApplicationRecord
  belongs_to :branch
  has_many :accounts, dependent: :destroy
  has_many :loans
  validates :name,
            :father_name,
            :mother_name,
            :age,
            :address,
            :contact_no,
            presence: true
  validates :contact_no,
            length: { is: 10 },
            numericality: { only_integer: true }
  validate :age_vaild

  private

  def age_vaild
    errors.add(:age, 'age should be greater than 0') if age.nil? || age <= 0
  end
end
