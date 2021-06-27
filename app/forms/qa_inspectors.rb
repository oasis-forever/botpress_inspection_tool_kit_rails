class QaInspectors
  include ActiveModel::Model

  attr_accessor :scheme, :host, :bot_id, :user_id, :access_token, :test_data

  validates :scheme, presence: true
  validates :host, presence: true
  validates :bot_id, presence: true
  validates :user_id, presence: true
  validates :access_token, presence: true
  validates :test_data, presence: true

  def save
    valid? ? true : false
  end
end
