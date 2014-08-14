class Article < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments, :dependent => :destroy 
  belongs_to :user
  scope :unreleased, where(:created_at => nil)
  attr_accessible :user_id, :title, :text, :image, :remote_image_url, :tag_list
  mount_uploader :image, ImageUploader

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  include PgSearch
  pg_search_scope :search, :against => [:title, :text, :id, :user_id] 
 
end


