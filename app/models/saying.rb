class Saying
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :words

  validates :words, presence: true

  def id
    nil
  end

  def persisted?
    false
  end
end
