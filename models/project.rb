class Project < ActiveRecord::Base
  has_many :images, class_name: 'ProjectImage', foreign_key: 'project_id'
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank
end
