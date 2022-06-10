class StudentsController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def index
    students = Student.all
    render json: students, status: :ok
  end

  def show
    student = Student.find_by(id: params[:id])
    if student
      render json: student, status: :ok
    else
      render json: {error: "Student not found"}, status: :not_found
    end
  end

  def destroy
    student = Student.find_by(id: params[:id])
    if student
      student.destroy
      head :no_content
    else
      render json: {error: "Student not found, cannot be deleted"}, status: :not_found
    end
  end

  def create
    new_student = Student.create!(student_params)
    render json: new_student, status: :created
  end

  def update
    updated_student = Student.find_by(id: params[:id])
    updated_student.update!(student_params)
    render json: updated_student, status: :ok
  end

  private

  def student_params
    params.permit(:name, :age, :major, :instructor_id)
  end

  def render_record_not_found(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :not_found
  end

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
