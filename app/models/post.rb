class Post < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  validates :user, :presence => true

  before_save :sanitize_title

  # http://guides.rubyonrails.org/active_record_querying.html#scopes
  scope :published, -> { where(published: true) }

  def length
    len = message.length
    len == 0 ? nil : len
  end

  def unpublish!
    self.published = false
    self.save
  end

  def self.unpublish_all
    Post.where(published: true).each do |post|
      post.unpublish!
    end
  end

private
  def sanitize_title
    return if self.title.nil?
    self.title[0] = self.title[0].capitalize
  end
end
