class CourseRegistrationsController < ApplicationController
	before_action :set_course, only: [:create]
	before_action :set_course_registration, only: [:destroy, :update, :edit]

	def index
		@courses_users_register_to = []
		current_user.courses.order('updated_at DESC').each { |course| course.course_registrations.each { |cr| @courses_users_register_to << cr if cr.approval_status == false } }
	end

	def create
		@course_registration = current_user.course_registrations.build(course_regis_params)
		@course_registration.course_id = @course.id
		@course_registration.user_role = User.roles[current_user.role]
		@course_registration.approval_status = false
		if @course_registration.save
      		render json: @course_registration
		end
	end

	def edit

	end

	def update
		@course_registration.approval_status = true
		respond_to do |format|
			if @course_registration.save
				format.js { flash.now[:notice] = "Student Accepted" }
			else
				format.html { render :edit }
				format.json { render json: @course.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@course_registration.destroy
		respond_to do |format|
			format.js { flash.now[:notice] = "Student Rejected" }
		end
	end

	private
	def registration_approved
		params.require(:course_registration).permit(:approval_status)
	end
	
	def set_course_registration
		@course_registration = CourseRegistration.find(params[:id])
	end

	def set_course
		@course = Course.find(params[:course_id])
	end

	def course_regis_params
		params.permit(:user_role)
	end

end
