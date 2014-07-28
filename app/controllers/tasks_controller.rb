class TasksController < ApplicationController
	def index
		@exams=[]
		#~ [	"Rosi Deshova",
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
			#~ "Kiril"].sort
		0.upto(5).each { |number| @exams<<Exam.new(number)}
	end	
end
