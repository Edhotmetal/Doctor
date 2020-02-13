# You will be annoyed

require_relative 'patient.rb'
require_relative 'robotnik.rb'

patient = Patient.new
puts("Patient name is #{patient.name}")
doc = Robotnik.new

doc.greeting(patient)

# This is the main loop of the program
# It "runs" the doctor
while(doc.listen(patient)) do
end
