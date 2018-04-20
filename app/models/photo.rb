class Photo < ActiveRecord::Base
  belongs_to :post
  validates_format_of :url, with: /\.(gif|jpg|png)\z/i

  # gets filename from url
  def file
    return nil unless self.valid?
    /(\w+)(\.\w+)+(?!.*(\w+)(\.\w+)+)/.match(url)[0]
  end

  # gets file type from url
  def file_format
    return nil unless self.valid?
    /(\w+)(\.\w+)+(?!.*(\w+)(\.\w+)+)/.match(url)[2].gsub(".","")
  end

  def self.all_urls
    Photo.all.pluck(:url)
  end

end
