class Sample < ActiveRecord::Base
  has_one :sample_group
  validates_presence_of :samples_group, :created_by, :created_by_uid, :content
end