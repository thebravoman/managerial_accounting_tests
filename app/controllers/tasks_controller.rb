class TasksController < ApplicationController
	def index
		@exams=[]
		[	"Rosi Deshova",
			#~ "Yavor",
			#~ "Dinko",
			#~ "Ivan",
			#~ "Rali",
			#~ "Dimi",
			#~ "Geri",
			#~ "Desi",
			#~ "Tedy",
			#~ "Radi",
			#~ "Ivo",
			#~ "Aleks",
			#~ "Nadya",
			#~ "Kris",
			#~ "Vesi",
			#~ "Anna",
			#~ "Rafi",
			#~ "Ilyan",
			#~ "Niki",
			"Kiril"].sort
		.each { |name| @exams<<Exam.new(name)}
	end	
end
