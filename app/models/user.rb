class User < ActiveRecord::Base
  has_many :comments
  has_many :commented_posts, through: :comments, source: :post
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def self.export(format:)
    raise ArgumentError if format != :json
    all.to_json(except: [:created_at, :updated_at])
  end
end
