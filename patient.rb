
require_relative 'person.rb'

class Patient < Person

    def initialize()
        super()
		@medications = Array.new
		@symptoms = Array.new
    end

    def add_symptom(symptom)
        @symptoms.push(symptom)
    end

	def symptoms()
		return @symptoms
	end

    def add_medication(medication)
        @medications.push(medication)
    end

	def medications()
		return @medications
	end
end

