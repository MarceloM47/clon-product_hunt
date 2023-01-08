# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  visible     :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#
class Product < ApplicationRecord

    extend FriendlyId
    friendly_id :name, use: :slugged

    validates :name, presence: { message: 'El nombre es requerido.' }
    validates :description, presence: { message: 'La descripción es requerida.' }

    validates :name, length: {minimum:2, maximum:100, message: 'Es demasiado corto debe de tener como mínimo 2 carácteres'}

    has_one_attached :image, :dependent => :destroy

    has_many :product_categories
    has_many :categories, through: :product_categories

    has_many :comments, -> { order('id DESC') }

    accepts_nested_attributes_for :categories

    def category_default
        return self.categories.first.name if self.categories.any?
        'Sin categoría'
    end
end