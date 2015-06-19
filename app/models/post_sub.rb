class PostSub < ActiveRecord::Base
  validates :post_id, :sub_id, presence: true

  belongs_to :sub
  belongs_to :post 
end
