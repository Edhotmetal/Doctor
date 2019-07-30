# You will be fooled and think this program actually knows something

require_relative 'patient.rb'
require_relative 'doctor.rb'

patient = Patient.new
puts("Patient name is #{patient.name}")
doc = Doctor.new

doc.greeting(patient)

# This is the main loop of the program
# It "runs" the doctor
while(doc.listen(patient)) do
end
