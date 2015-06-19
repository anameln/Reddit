# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validate :has_a_sub


  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many :post_subs,
  inverse_of: :post

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )

  private

    def has_a_sub
      errors.add(:sub_ids, "no subs") if subs.empty?
    end

end
