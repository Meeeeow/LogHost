class Log < ActiveRecord::Base
  validates_presence_of :created_by, :created_by_uid, :content
end