class Post < ApplicationRecord
  belongs_to :user
  validates :title, :date, :area_id, :postal, :place, :venue, :capacity, :remarks, presence: true

  def self.search(search)
    return Post.all unless search
    Post.where('area_id  LIKE(?)', "%#{search}%")
  end
end
