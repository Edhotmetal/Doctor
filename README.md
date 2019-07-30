# Doctor
This doctor solves all of your problems! Written in Ruby

Start the action by running "ruby runDoctor.rb" in the command line
Ask the doctor whatever you like and complain when you get illogical or irrelevant responses.

# person.rb
Extended by doctor and patient

The contructor randomly assigns:
-first_name
-last_name
-age
-gender
when a new Person object is created

This file contains the list of random names
An 'f' or 'm' is appended to the end of each first name to indicate gender.
This character is removed when the name is assigned to the person

# doctor.rb
Extends the Person class

This contains the Doctor class and all of the logic.
Doctor objects use the same constructor from Person so the doctor is random as well

- **greeting(patient)**
Outputs a greeting to the user and asks if the user is taking any medication

- **ask_for_first_name()**
Asks for the user's first name and returns the input

- **ask_for_last_name()**
Asks for the user's last name and returns the input

- **ask_for_gender()**
Asks for the user's gender and returns the input
Loops until the user gives a valid response
Gender is not currently implemented anywhere else. I might implement it later?

- **ask_for_age()**
Asks for the user's age and returns the input
Loops until the user gives an integer
Age isn't implemented anywhere else either

- **is_number(text)**
Apparently, Ruby doesn't have a method that checks if a string is a valid number
So I copied this off of Stack Overflow
I use this to make sure the user's input doesn't cause errors

- **finish(patient)**
This method is called when the user is finished talking with the doctor
Prints a farewell message and the number of queries the user made

- **ask_for_medications(patient)**
This method asks for the user's medications and appends them to the patient's list of medications
This method does not receive input with gets but rather from the listen method in order to make
input feel more natural. i.e the user can interrupt the doctor and make something else happen
before continuing with medications.

- **ask_for_symptoms(patient)**
This method is identical to ask_for_medications except it asks for symptoms and appends
to the patient's symptoms list

- **show_medications(patient)**
This method prints a list of the patient's medications with an integer on the left hand side
and gives the user the option to remove one from the list
The integers on the left side can be used by the user to refer to a medication without having to type the whole name

- **show_symptoms(patient)**
This method is identical to show_medications except it deals with the patient's list of symptoms

- **listen(patient, \*options)**
This is the main logic method that responds to the user's input
Instead of matching text, it checks if the user's input contains certain keywords.
For example, it checks if "your name" is present in the user's input so "what is your name",
"I don't know your name", and "tell me your name" all trigger the doctor to state its name.
However, "I don't like your name" would also elicit the same response.
It shouldn't be too hard to address this.

If none of the keywords match, the doctor spits out a random response from the list of responses.
\*options is used by the caller to bypass certain keyword checks so that the user's input isn't gobbled up by listen

# patient.rb
extends Person

This is you!
Contains the Patient class
The contructor uses the Person constructor and then creates an Array each for medications and symptoms.

- **add_symptom(symptom)**
Adds a symptom to the list of symptoms

- **symptoms()**
Returns the list of symptoms

- **add_medication(medication)**
Adds a medication to the list of medications

- **medications()**
Returns the list of medications
