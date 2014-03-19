class ContactMessage
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Translation
  extend ActiveModel::Naming

  # attr_accessor :name, :email, :content

  validates_presence_of :name, :email, :content
  validates :email, length: {:minimum => 3, :maximum => 254},
            :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates_length_of :content, :maximum => 500

  def initialize(attributes = {})
    # attributes.each do |name, value|
    #   send("#{name}=", value)
    # end
    @attributes = attributes
  end

  def persisted?
    false
  end
end