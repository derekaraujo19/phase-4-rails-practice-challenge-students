class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


  # How do I make sure that the student created is getting created with a teacher that already exists
  def create
    student = Student.create!(student_params)
    render json: student, status: :created
  end

  def index
    students = Student.all
    render json: students
  end

  def show
    student = Student.find(params[:id])
    render json: student
  end

  def update
  end

  def destroy
  end

  private

  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

end
