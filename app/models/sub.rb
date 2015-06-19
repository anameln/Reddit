# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  description  :text             not null
#  moderator_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many(
    :post_subs,
    class_name: "PostSub",
    foreign_key: :sub_id,
    primary_key: :id,
    inverse_of: :sub
  )

  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )

end
