class Topic < ActiveRecord::Base

	has_many :question_sets
	has_many :question_set_chapter_topics
	has_many :questions
	has_many :batch_set_chapter_topics#, dependent: :destroy
	has_many :knowledge_bases
	has_many :solutions

	has_many :chapter_topics#, dependent: :destroy
	has_many :chapters, through: :chapter_topics

	has_many :course_topics#, dependent: :destroy
	has_many :courses, through: :course_topics

	validates_presence_of :name, :course_ids

end