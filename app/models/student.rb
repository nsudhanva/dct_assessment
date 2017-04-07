class Student < ActiveRecord::Base

	after_create :create_user
	
	has_one :user

	has_many :batch_students
	has_many :batches, through: :batch_students


	private
	def create_user
		user = User.new
		user.student_id = self.id
		user.email = self.email
		user.password = "password"
		user.role_id = 2
		user.save 
	end

end