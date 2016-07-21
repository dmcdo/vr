class Course < ActiveRecord::Base
  belongs_to :instructor, class_name: 'User'

  has_many :course_registrations
  has_many :users, through: :course_registrations

  has_many :course_topics
  has_many :topics, through: :course_topics
end
