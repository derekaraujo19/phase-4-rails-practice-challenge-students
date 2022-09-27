class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  def create
    instructor = Instructor.find(params[:instructor_id])
    student = Student.create!(
      name: params[:name],
      major: params[:major],
      age: params[:age],
      instructor_id: instructor.id
    )
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
    instructor = Instructor.find(params[:instructor_id])
    student = Student.find(params[:id])
    student.update!(
      name: params[:name],
      major: params[:major],
      age: params[:age],
      instructor_id: instructor.id
    )
    render json: student
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
    head :no_content
  end

  private

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: "Student not found" }, status: :not_found
  end

end
