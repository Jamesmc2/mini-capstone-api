class Product < ApplicationRecord
  belongs_to :supplier
  has_many :images
  has_many :orders
  has_many :category_products
  validates :name, uniqueness: true, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { in: 10..500 }
  validates :description, presence: true

  def is_discounted?
    if price > 10
      return false
    else
      return true
    end
  end

  def tax
    tax = price * 0.09
    return tax
  end

  def total
    total = price + tax
    return total
  end
end
