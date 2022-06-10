class StudentSerializer < ActiveModel::Serializer
  attributes :name, :age, :major

  belongs_to :instructor
  
end
