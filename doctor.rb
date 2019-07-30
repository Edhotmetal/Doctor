require_relative 'person.rb'

class Doctor < Person

    @@num_queries = 0
	# Create the random responses that will be used when the doctor doesn't have any programmed response
	@@responses = ["Is that really how you feel?",
				"I understand completely.",
				"Maybe I can help with that.",
				"Do you have any symptoms related to that?",
				"Are you getting enough sleep?",
				"Sleep is very important to maintaining a healthy lifestyle. You should consider if lack of sleep may be the cause.",
				"Tell me more.",
				"Wow",
				"Maybe it's time you let go?",
				"Are you eating enough?",
				"You can open up to me.",
				"How do you feel about that?",
				"That must be concerning.",
				"Hmm.",
				"Of course."]

	@@solutions = ["Get more sleep. At least 7 hours a night.",
				"Read a book",
				"Have an apple a day. But still come and visit me, okay?",
				"Have a cookie and call me in the morning.",
				"Make a habit of exercising in the morning.",
				"Eat your veggies!",
				"Eat your fruits!",
				"Plant a garden!",
				"Get a new hobby.",
				"Get a life.",
				"Reduce your intake of toxic waste.",
				"Increase your intake of toxic waste. You might turn into a super hero and then you won't have to worry about it anymore.",
				"Become the Batman."]

    attr_accessor :num_queries # Basically, the number of times listen is called

	# Inflexibly the first method to be called
    def greeting(patient)
        puts("Hello, #{patient.first_name}. I am a doctor. I am here to help.")
        puts("For starters, I need a bit of information.")
        ask_for_medications(patient)
        puts("Okay, let's get started. How can I help you?")
    end
    
    def ask_for_first_name()
        print ("What is your first name? ")
        return gets().chop
    end

    def ask_for_last_name()
        print("What is your last name? ")
        return gets().chop
    end

	# Loops until the user gives a valid response
    def ask_for_gender()
        loop do
            print("What is your gender? ")
            gender = gets().chop
            if(gender.casecmp('f') == 0 or gender.casecmp('m') == 0 or gender.casecmp('female') == 0 or gender.casecmp('male') == 0) then
                return gender
            end
        end
    end

	# Loops until the user gives an integer
    def ask_for_age()
        loop do
            print("What is your age? ")
            age = gets().chop
            if(is_number(age)) then
                return age.to_i
            end
        end
    end

	# This checks if a given string is a number

    def is_number(text) !!(/^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$/ =~ text) end
    
	def finish(patient)
		puts("Thank you for coming today #{patient.name}. Please give me a call in the next few days")
		puts("You made #{@@num_queries} queries")
	end

	# Listen can potentially branch off and do other things before coming back here depending on the user's input
	# This method checks if that has happened by checking if listen has returned "next"
    def ask_for_medications(patient)
        print("Are you taking any medications? ")
        loop do
            input = listen(patient, 'query')
			if(input == "next") then
				puts("What medication are you taking? ")
				next
			end
            if(input.downcase().include?("yes")) then
                loop do
                    print("\nWhat medication are you taking? ")
                    input = listen(patient, 'query')
                    if(input == "next") then
                        next
                    end
                    patient.add_medication(input)
					break
                end
                print("Any other medication? ")
			elsif(input.downcase.include?("no") or input.downcase.include?("not")) then
                puts("Okay")
                break
            else
                patient.add_medication(input)
                print("Any other medication? ")
            end
        end
    end

	def ask_for_symptoms(patient)
        print("So you are having various symptoms? ")
        loop do
            input = listen(patient, 'symptom')
            if(input.downcase().include?("yes") or input.downcase().include?("i do have")) then
                loop do
                    print("\nWhat sort of symptoms? ")
                    input = listen(patient, 'symptom')
                    if(input == "next") then
                        next
                    end
                    patient.add_symptom(input)
					break
                end
                print("Any other symptoms? ")
			elsif(input.downcase.include?("no") or input.downcase.include?("not")) then
                puts("Okay")
                break
            else
                patient.add_symptom(input)
                print("Any other symptoms? ")
            end
        end
	end

	# Prints the list of medications and gives the user the option of removing one from the list
	def show_medications(patient)
		puts("Lets see ... I have here that you are taking:")
		# Prints the list of medications with the index of each on the left hand side
		patient.medications.each { |med| puts("#{patient.medications.index(med)} #{med}") }
		print("Is this correct? ")
		input = gets()
		if(input.downcase.include?("no") or input.downcase.include?("not")) then
			loop do
				puts("What medication would you like me to remove?")
				input = gets.chop
				if(input.downcase.include?("stop") or input.downcase.include?("any more")) then
					puts("Okay")
					break
				elsif(is_number(input)) then
					if(input.to_i > patient.medications.length - 1) then
						puts("There are not that many medications on the list")
						next
					end
					puts("I removed #{patient.medications[input.to_i]} from your list of medications")
					patient.medications.delete_at(input.to_i)
					break
				elsif(patient.medications.include?(input)) then
					patient.medications.delete(input)
					puts("I removed #{input} from your list of medications")
					break
				else
					puts("It looks like that medication is not on the list.")
				end
			end
		end
	end
					
	# Prints the list of symptoms and gives the user the option of removing one from the list
	def show_symptoms(patient)
		puts("Lets see ... I have here that you are taking:")
		# Prints the list of symptoms with the index of each on the left hand side
		patient.symptoms.each { |symptom| puts("#{patient.symptoms.index(symptom)} #{symptom}") }
		print("Is this correct? ")
		input = gets()
		if(input.downcase.include?("no") or input.downcase.include?("not")) then
			loop do
				puts("What symptom would you like me to remove?")
				input = gets.chop
				if(input.downcase.include?("stop") or input.downcase.include?("any more")) then
					puts("Okay")
					break
				elsif(is_number(input)) then
					if(input.to_i > patient.symptoms.length - 1) then
						puts("There are not that many symptoms on the list")
						next
					end
					puts("I removed #{patient.symptoms[input.to_i]} from your list of symptoms")
					patient.symptoms.delete_at(input.to_i)
					break
				elsif(patient.symptoms.include?(input)) then
					patient.symptoms.delete(input)
					puts("I removed #{input} from your list of symptoms")
					break
				else
					puts("It looks like that symptom is not on the list.")
				end
			end
		end
	end

    # listen(patient, *options) is the "main" method for the doctor
	# The loop in runDoctor.rb repeatedly calls this to elicit more queries from the user
    # Ideally, other methods should take user input from this method
	# in order to make input feel more natural

    def listen(patient, *options)
        @@num_queries += 1
        input = gets().chop

		# Change the user's name
        if(input.downcase().include?("my name is") or input.downcase().include?("that's not my name") or 
		input.downcase().include?("that is not my name"))
            puts("My deepest apologies.")
            patient.first_name = ask_for_first_name()
            patient.last_name = ask_for_last_name()
            patient.gender = ask_for_gender()
			patient.age = ask_for_age()
            puts("\nOkay, #{patient.name}. Back to where we were before...")
            return "next"
			# Ask for the doctor's name
        elsif(input.downcase().include?("your name") or
			input.downcase().include?("who are you")) then
            puts("My name is Dr. #{name}.")
            return "next"
			# User is talking about medications
        elsif(input.downcase().include?("i am taking") or input.downcase().include?("i'm taking"))
		  ask_for_medications(patient)
		  return "next"
		  # Check the list of medications
		elsif(input.downcase().include?("my medications") or input.downcase().include?("my meds")) then
			show_medications(patient)
			ask_for_medications(patient)
			# Check the list of symptoms
		elsif(input.downcase().include?("my symptoms")) then
			show_symptoms(patient)
			print("Do you have any other symptoms? ")
			input = gets()
			if(input.downcase.include?("no") or input.downcase.include?("not")) then
				puts("Okay, let's continue.")
			else
				ask_for_symptoms(patient)
			end
			# User is describing symptoms
		elsif(not(options.include?('symptom')) and (input.downcase().include?("symptom") or
		input.downcase().include?("bad") or input.downcase().include?("cough") or
		input.downcase().include?("pain") or input.downcase().include?("ache") or
		input.downcase().include?("ringing") or input.downcase.include?("sore") or
		input.downcase().include?("shortness") or input.downcase().include?("hard time") or
		input.downcase().include?("trouble") or input.downcase().include?("aching") or
		input.downcase().include?("discomfort") or input.downcase().include?("bowel") or
		input.downcase().include?("abnormal"))) then
			ask_for_symptoms(patient)
			# User asks the doctor for a solution
		elsif(input.downcase().include?("should i") or input.downcase().include?("tell me") or
			 input.downcase().include?("pray tell")) then
			give_solution(patient)
			# User has had enough of this nonsense
		elsif(input.downcase().include?("quit") or input.downcase().include?("end") or
		input.downcase().include?("farewell") or input.downcase().include?("bye") or
		input.downcase().include?("adieu")) then
			finish(patient)
			return false
		elsif(not(options.include?('query') or options.include?('symptom')))
			puts(@@responses[Random.rand(@@responses.length-1)]) # If nothing else applies, output a random response from the list
		end
		return input
	end

	# give the patient a solution for every symptom
	def give_solution(patient)
		if(patient.symptoms.length == 0) then
			puts("You do not have any symptoms for me to solve")
		else
			puts("Here is my recommendation:")
			solutions = Array.new
			for symptom in patient.symptoms do
				puts("For #{symptom}, I recommend:")
				loop do
					solution = Random.rand(@@solutions.length-1)
					if(solutions.include?(@@solutions[solution])) then
						next
					else
						solutions.push(@@solutions[solution])
						puts(@@solutions[solution])
						break
					end
				end
			end
		end
	end
end
# This is the end
