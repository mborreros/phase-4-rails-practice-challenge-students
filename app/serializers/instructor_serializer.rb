class InstructorSerializer < ActiveModel::Serializer
  attributes :name

  has_many :students
  
end
