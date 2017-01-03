class SamplesGroup < ActiveRecord::Base
  validates_presence_of :title, :created_at, :title
  has_many :samples
end