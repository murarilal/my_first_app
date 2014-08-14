class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  attr_accessible :name, :description, :category_id	
    searchable do
      text :name, :boost => 2
      text :description
    end
end
