class Url < ActiveRecord::Base
  belongs_to :user
  validates :long_url, presence: true
  validates :long_url, format: {with: /\A(https?:)/}
  validates :long_url, :uniqueness => true
  before_create :create_short_url

  def create_short_url

    short_url = ""
    key = ('a'..'z').to_a
    while Url.find_by_short_url(short_url) != nil
      5.times do
        short_url << key.sample
      end
    end
    self.short_url = short_url
  end
end
