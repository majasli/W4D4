class Album < ApplicationRecord

  validates :title, :year, :band, presence: :true
  validates :title, uniqueness: { scope: :band_id }
  validates :live, inclusion: { in: [true, false] }

  belongs_to :band

end
