class InstructorsController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def index
    instructors = Instructor.all
    render json: instructors, status: :ok
  end

  def show
    this_instructor = Instructor.find_by(id: params[:id])
    if this_instructor
      render json: this_instructor, status: :ok
    else
      render json: {error: "Instructor not found"}, status: :not_found
    end
  end

  def destroy
    this_instructor = Instructor.find_by(id: params[:id])
    if this_instructor
      this_instructor.destroy
      head :no_content
    else
      render json: {error: "Instructor not found, cannot delete"}, status: :not_found
    end
  end

  def create
    new_instructor = Instructor.create!(instructor_params)
    render json: new_instructor.to_json(only: [:name]), status: :created
  end

  def update
    updated_instructor = Instructor.find_by(id: params[:id])
    updated_instructor.update!(instructor_params)
    render json: updated_instructor.to_json(only: [:name]), status: :ok
  end

  private

  def instructor_params
    params.permit(:name)
  end

  def render_record_not_found(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :not_found
  end

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
