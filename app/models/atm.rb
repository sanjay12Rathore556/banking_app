# frozen_string_literal: true

# Description/Explanation of Person class
class Atm < ApplicationRecord
  belongs_to :bank
  has_many :transactions
  validates :name, :address, presence: true
end
