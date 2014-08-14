ActiveAdmin.register Article do
  scope :unreleased 
  index do
    column :id
    column :title
    column :text
    column :image
    column :user_id
    column "Released Date", :created_at
    column "Update date",:updated_at
  end
end
  