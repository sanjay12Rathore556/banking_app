class Manager < ApplicationRecord
  belongs_to :branch
  validates :name,:address,:contact_no,presence: true
  validates :contact_no,length: {is:10}, numericality: {only_integer: true}
end
