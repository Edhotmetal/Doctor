# The Robotnik class extends Doctor
# This class has slightly different behavior than the Doctor but still performs the same functions, more or less

require_relative 'doctor.rb'

class Robotnik < Doctor

	@@responses = ["No way!",
				"I can't believe this!",
				"He's not going to get away with this!",
				"She's not going to get away with this!",
				"He's not going to get away with that!",
				"She's not going to get away with that!",
				"See if you can tell me more about your symptoms",
				"Alas!",
				"Behold! It's a tailed frog! What were we talking about again?",
				"Very unique!",
				"Tell me more",
				"Of course",
				"Aha!"]

	@@solutions = ["Come to my theme park!",
				"Come work for me!",
				"Pay me more and I might come up with something.",
				"If only this application accepted bitcoin payments. Then I could tell you.",
				"It's all Sonic's fault.",
				"Create a fleet of airships. It's quite liberating. I know.",
				"Take over the world!"]

	def initialize()
		@first_name = "Ivo"
		@last_name = "Robotnik"
		@gender = "m"
		@age = 50
	end

	def greeting(patient)
		puts("Hello, #{patient.first_name}. I am a doctor, it's true.")
		puts("Surely, you are taking some medications.")
		ask_for_medications(patient)
		puts("I am a very busy scientist. Please continue")
	end

	def finish(patient)
		puts("You have been most informative.")
		puts("You made #{@@num_queries} queries")
	end

	def listen(patient, *options)
        @@num_queries += 1
        input = gets().chop

		# If the input is empty
		if(input == "") then
			puts("Orbot! Where's my sandwich?")
		# The user asks if the doctor can help
		elsif(input.downcase == "Can you help me?" or input.downcase == "Can you help with that?") then
			puts("You would dare doubt me?")
		# Change the user's name
        elsif(input.downcase().include?("my name is") or input.downcase().include?("that's not my name") or 
		input.downcase().include?("that is not my name"))
			puts("You can blame Cubot for that.")
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
			puts("Are you taking any other medications?")
			input = gets
			if(input.downcase.chop == "yes") then
				ask_for_medications(patient)
			else
				puts("Okay")
			end
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
		input.downcase().include?("shortness") or input.downcase().include?("hard") or
		input.downcase().include?("trouble") or input.downcase().include?("aching") or
		input.downcase().include?("discomfort") or input.downcase().include?("bowel") or
		input.downcase().include?("abnormal") or input.downcase().include?("stuffy"))) then
			ask_for_symptoms(patient)
			# User asks the doctor for a solution
		elsif(input.downcase().include?("should i") or input.downcase().include?("tell me") or
			 input.downcase().include?("pray tell") or input.downcase().include?("can you help me") or
			 input.downcase().include?("what to do")) then
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
end
