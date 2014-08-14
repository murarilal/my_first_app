class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  attr_accessible :user_id, :article_id, :commenter, :body
 
end
