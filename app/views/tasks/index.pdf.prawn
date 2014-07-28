require "prawn/table"

def ntp value
	"<b>#{number_to_percentage(value*100, :precision=>0)}</b>"
end

def ntc value
	"<b>#{number_to_currency(value, :precision=>0)}</b>"
end

def write_title exam, pdf, title
	pdf.text "AUBG Cohor 13"
	pdf.text "BUS 512 Exam 2 - Summer 2014, <b>#{title}</b>", :inline_format=>true
	pdf.text "Student name: <b>#{exam.name}</b>", :inline_format=>true
	pdf.image "index.jpeg", :at => [420, 725], :scale => 0.4
	pdf.move_down(12)
end

def write_questions exam, pdf
	write_title exam, pdf, "Exam"

	pdf.text "<b>Question 1:</b>", :inline_format=>true
	pdf.text "Management is considering investing into the production of a new soup. In order to go into this business they need to purchase a machine. The machine costs #{ntc(exam.question1[:machine_costs])} and would bring them additional cash sales of #{ntc(exam.question1[:cash_sales])} per year and costs of #{ntc(exam.question1[:costs])} each year (all in cash). The machine's life is #{exam.question1[:years]} years and the salvage (scrap) value is #{ntc(exam.question1[:salvage])}. Working capital needed for this investment is #{ntc(exam.question1[:working_capital])}</b> and would be released after #{ntc(exam.question1[:years])} years.", :inline_format=>true
	
	pdf.move_down(12)
	pdf.text "The company uses a #{ntp(exam.question1[:discount_rate])} discount rate and the tax rate is #{ntp(exam.question1[:tax_rate])}. The machine is depreciated using the <b>#{exam.question1[:depreciation_method]}</b> over its useful life (note that salvage value should be deducted from the costs to get the depreciation)", :inline_format=>true
	
	pdf.move_down(12)
	pdf.text "a) Construct the timeline of cash flows for this project in excel (in good form). (8 points)"
	pdf.text "b) Conculate the NPV of purchasing this machine. Is this a good investment according to this method? (6 points)"
	pdf.text "c) Calculate the IRR or purchasing this machine. Is this a good investment according to this method? (6 points)"

	pdf.move_down(12)
	pdf.text "<b>Question 2:</b>", :inline_format=>true
	pdf.text "You are given the following information regarding the production at Pirin PLC"
	opening_data = [["Opening cash balance", "#{number_to_currency(exam.question2[:ocb],:precision=>0)}",""], 
                  ["Opening payables", "#{number_to_currency(exam.question2[:op],:precision=>0)}","...remaining from last quarter Purchases"], 
                  ["Opening Receivables", "#{number_to_currency(exam.question2[:oreceivables],:precision=>0)}","...remaining from last quarter Sales"]]
	pdf.table(opening_data)
	
	pdf.move_down(12)
	sales_data = [["", "Q1", "Q2", "Q3", "Q4"],
				["Planned capital expenditure", "#{number_to_currency(exam.question2[:pce][:q1],:precision=>0)}", "#{number_to_currency(exam.question2[:pce][:q2],:precision=>0)}","",""],
				["Sales","#{number_to_currency(exam.question2[:sales][:q1],:precision=>0)}","#{number_to_currency(exam.question2[:sales][:q2],:precision=>0)}","#{number_to_currency(exam.question2[:sales][:q3],:precision=>0)}","#{number_to_currency(exam.question2[:sales][:q4],:precision=>0)}"]
				]
	pdf.table(sales_data,:header=>true)
	
	pdf.move_down(12)
	pdf.text "Cash from sales are received #{ntp(exam.question2[:cash_received][0])} in the quarter of the Sales, and #{ntp(exam.question2[:cash_received][1])} the quarter after the sale", :inline_format=>true
	pdf.text "Purchases are #{ntp(exam.question2[:purchase_from_sales])} of Sales", :inline_format=>true
	pdf.text "Purchases are paid #{ntp(exam.question2[:purchase_paid][0])} in the quarter of the purchases and #{ntp(exam.question2[:purchase_paid][1])} in the quarter after the purchase", :inline_format=>true
	
	pdf.move_down(12)
	
	if(exam.question2[:loan])
		pdf.text "<b>A 2-year load for $5,000 is taken on 1st of July, interest is paid quarterly at the end of the quarter, while the principal is paid at the end of the maturity of the loan.</b>", :inline_format=>true
	end
	
	pdf.move_down(12)
	pdf.text "The following expenses are paid in teh same quarter"
	pdf.text "Labor is #{ntp(exam.question2[:labor_of_sales])} of Sales.", :inline_format=>true
	pdf.text "Overhead is #{ntc(exam.question2[:overhead])} per quarter and it <b>#{exam.question2[:dep_in_overhead_include]}</b> #{ntc(exam.question2[:dep_in_overhead])} of Depreciation.", :inline_format=>true
	pdf.text "Selling and administrative costs are $48,000 per year ($12,000 is the annual depreciation) which are spread evenly throughout the year.", :inline_format=>true
	
	pdf.move_down(12)
	pdf.text "<b>You are required to</b>", :inline_format=>true
	pdf.text "a) Construct the yearly cash budget (show each quarter seperately) (17 points)"
	pdf.text "b) Make recommendations based on your findings (3 points)"
end

def cells n
	result = []
	1.upto(n) {|x| result << ""}
	result
end

def write_solutions exam, pdf
	write_title exam, pdf, "Solutions"
	pdf.move_down(12)
	pdf.text "<b>Question1 Solution:</b>", :inline_format=>true
	
	q1 = exam.question1
	given_data = [
		["Depreciation",q1[:depreciation_method]],
		["Discount rate",ntp(exam.question1[:discount_rate])],
		["Tax rate", ntp(exam.question1[:tax_rate])],
	]
	pdf.table given_data, :cell_style => { :inline_format => true }
	
	pdf.move_down(12)
	years = exam.question1[:years]
	tax = (exam.question1[:cash_sales] - exam.question1[:costs])*exam.question1[:tax_rate]
	dep_reduction = (exam.question1[:machine_costs]-exam.question1[:salvage])/years*exam.question1[:tax_rate]
	net_income = exam.question1[:cash_sales] - exam.question1[:costs]-tax+dep_reduction
	net_income_years = [Array.new(years-1, net_income), net_income+exam.question1[:salvage]+exam.question1[:working_capital]].flatten
	by_years_data = [
		["Years",*0..years],
		["Machine costs", ntc(-exam.question1[:machine_costs]),cells(years)].flatten,
		["Working capital", ntc(-exam.question1[:working_capital]),cells(years-1),ntc(exam.question1[:working_capital])].flatten,
		["Additional cash", "", Array.new(years,ntc(exam.question1[:cash_sales]))].flatten,
		["Costs","",Array.new(years, ntc(-exam.question1[:costs]))].flatten,
		["Tax", "", Array.new(years, ntc(-tax))].flatten,
		["Depreciation tax reduction", "", Array.new(years,ntc(dep_reduction))].flatten,
		["Salvage", "", Array.new(years-1,""),ntc(exam.question1[:salvage])].flatten,
		["Net income", "", net_income_years.map {|a| ntc(a)}].flatten
	]
	pdf.text "<b>Cash flow</b>", :inline_format=>true
	pdf.table by_years_data, :cell_style => { :inline_format => true }
	
	pdf.move_down(12)
	pdf.text "a) NPV = #{number_to_currency(-exam.question1[:machine_costs]-exam.question1[:working_capital]+net_income_years.npv(exam.question1[:discount_rate]),:precision=>2)}"
	
	pdf.move_down(12)
	irr = [-exam.question1[:machine_costs]-exam.question1[:working_capital],net_income_years].flatten.irr
	pdf.text "b) IRR = #{number_to_percentage(irr*100,:precision=>2)}"
end

@exams.each do |exam|
	write_solutions exam, pdf
	pdf.start_new_page
	write_questions exam, pdf
	if(exam!= @exams.last)
		pdf.start_new_page
	end
end





