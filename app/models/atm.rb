# frozen_string_literal: true

class Atm < ApplicationRecord
  belongs_to :bank
  has_many :transactions
  validates :name, :address, presence: true
end
