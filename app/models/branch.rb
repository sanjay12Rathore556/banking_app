# frozen_string_literal: true

class Branch < ApplicationRecord
  belongs_to :bank
  has_many :users, dependent: :destroy
  has_one :manager, dependent: :destroy
  validates :IFSC_code, :address, presence: true
  validates :IFSC_code, uniqueness: true
  validates :contact_no, presence: true, length: { is: 10 }
end
