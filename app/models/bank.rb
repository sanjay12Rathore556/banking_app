class Bank < ApplicationRecord
  has_many :branches, dependent: :destroy
  has_many :atms, dependent: :destroy
  validates :name, :contact_no, presence: :true
  validates :contact_no, numericality: { only_integer: true}, length:{ is: 10 }	
end