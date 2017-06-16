class Question < ActiveRecord::Base
	
	belongs_to :chapter
	belongs_to :topic
	belongs_to :question_type

	has_many :options #, dependent: :destroy
	accepts_nested_attributes_for :options, :allow_destroy => true
	has_many :videos #, dependent: :destroy
	accepts_nested_attributes_for :videos, :allow_destroy => true
	has_many :solutions
	accepts_nested_attributes_for :solutions, :allow_destroy => true
	
	has_many :question_sets
	has_many :answers #, dependent: :destroy

	has_many :batch_set_questions #, dependent: :destroy
	has_many :batch_sets , through: :batch_set_questions

	validates_presence_of :statement, :chapter_id, :topic_id, :question_type_id, :kind
	validates_uniqueness_of :code
	
	before_validation :question_code
	after_create :correct_answer_option
	before_destroy :delete_question_from_qustion_sets

	def self.difficulty 
		["easy","easy-medium","medium", "medium-hard", "hard"]
	end

	def formatted_statement
		self.statement.html_safe
	end

	private
	def correct_answer_option
	  if self.question_type_id == 1
	  	option = options.find_by_is_answer(true)
	  	update(answer_option_id: option.id)
	  else
	  	return
	  end
	end

	def delete_question_from_qustion_sets
		QuestionSet.all.each do |question_set|
			if question_set.question_ids.include?(self.id)
				question_set.question_ids = question_set.question_ids - [question_set.question_ids.find {|question_id| question_id == self.id}]
			end
		end
	end

	# DCT-1EMT-ARR-0001
	def question_code
		if self.code.nil? || self.new_record?
			kind_code = ""
			if self.kind == "assessment"
				kind_code = "1"
			elsif self.kind == "assignment"
				kind_code = "2"
			end
			
			type_code = ""
			if self.question_type.name == "MCQ"
				type_code = "M"
			elsif self.question_type.name == "Text"
				type_code = "T"
			end

			difficulty_code = ""
			self.difficulty_level.split("-").each do |difficulty_level|
				difficulty_code += difficulty_level[0].capitalize
			end

			num = 0
			questions = []
			questions = Question.where(question_type_id: self.question_type_id, kind: self.kind, chapter_id: self.chapter.id, difficulty_level: self.difficulty_level) if Question.where(question_type_id: self.question_type_id, kind: self.kind, chapter_id: self.chapter.id, difficulty_level: self.difficulty_level).exists?
			question = ""
			question_digits = ""
			if questions.empty?
				question_digits = "0001"
			else
				question = questions.last
				if question.code.nil?
					question_digits = "0001"
				else
					question_digits = (question.code.split("-").last.to_i + 1).to_s.rjust(4,'0') 
				end
			end

			self.code = "DCT-" + kind_code + difficulty_code + type_code + "-" + self.chapter.short_name + "-" + question_digits
		end
	end

end