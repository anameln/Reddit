class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many :post_subs

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )

end
