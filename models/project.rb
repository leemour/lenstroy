class Project < ActiveRecord::Base
  has_many :images, class_name: 'ProjectImage', foreign_key: 'project_id'#,
    #:table_name => :project_images, inverse_of: :project#, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
end
