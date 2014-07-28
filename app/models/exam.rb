class Exam
	attr_reader :number
	attr_reader :name	
	attr_reader :question2
	attr_reader :question1
	
	def initialize name
		@name = name
		@number = number
		@question1={
			machine_costs: sample(70000..100000, 5000),
			cash_sales: sample(90000..130000, 5000),
			costs: sample(70000..80000, 1000),
			years: sample(3..5,1),
			salvage: sample(5000..10000,5000),
			working_capital: 20000,
			discount_rate: sample(8..12, 1).to_f/100,
			tax_rate: sample(15..25, 1).to_f/100,
			depreciation_method: "stright line method"
		}
		@question2={
			ocb: sample(8000..12000, 1000),
			op: sample(4000..6000,500),
			oreceivables: sample(14000..17000, 1000),
			pce: 
				{	q1: sample(20000..30000, 1000),
					q2: sample(31000..39000, 1000),
				},
			sales: 
				{	q1: sample(95000..105000,1000), 
					q2: sample(75000..85000,1000), 
					q3: sample(65000..75000,1000), 
					q4: sample(55000..65000,200)
					},
			cash_received: [75,25],
			purchase_from_sales: 40,
			purchase_paid: [60,40],
			loan: [true,false].sample,
			labor_of_sales: 25,
			overhead: 6000,
			dep_in_overhead_include: ["includes","does not include"].sample,
			dep_in_overhead: 1500
			}
	end
	
	private
	def find_solutions
		find_question1_solution
	end
	
	def find_question1_solution
		
	end
	
	def sample range, step
		range.step(step).to_a.sample
	end
	
end
