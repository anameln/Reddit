# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class PostSub < ActiveRecord::Base
  validates :post, :sub, presence: true

  belongs_to(
    :sub,
    class_name: 'Sub',
    foreign_key: :sub_id,
    primary_key: :id,
    inverse_of: :post_subs
  )
  belongs_to(
    :post,
    class_name: 'Post',
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :post_subs
  )
end
