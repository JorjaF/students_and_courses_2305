require 'rspec'
require './lib/course'
require './lib/student'
require './lib/gradebook'

RSpec.describe Gradebook do

  it "exists and has attributes" do
    gradebook = Gradebook.new("Ron")

    expect(gradebook).to be_a(Gradebook)
    expect(gradebook.instructor).to eq("Ron")
  end

  it "starts with no courses" do
    gradebook = Gradebook.new("Ron")

    expect(gradebook.courses).to eq([])
  end

  it "can add courses" do
    gradebook = Gradebook.new("Ron")

    gradebook.add_course(Course.new("Calculus", 2))
    gradebook.add_course(Course.new("Chemistry", 2))
  end

  it "can list all students in a course" do
    gradebook = Gradebook.new("Ron")
    gradebook.add_course(Course.new("Calculus", 2))
    gradebook.add_course(Course.new("Chemistry", 2))

    student1 = Student.new({name: "Morgan", age: 21})
    student2 = Student.new({name: "Jordan", age: 29})

    gradebook.courses[0].enroll(student1)
    gradebook.courses[0].enroll(student2)

    expect(gradebook.list_all_students).to eq({gradebook.courses[0] => [student1, student2], gradebook.courses[1] => []})
  end

  it "knows when students are below a threshold" do
    gradebook = Gradebook.new("Ron")
    gradebook.add_course(Course.new("Calculus", 2))
    gradebook.add_course(Course.new("Chemistry", 2))

    student1 = Student.new({name: "Morgan", age: 21})
    student2 = Student.new({name: "Jordan", age: 29})

    gradebook.courses[0].enroll(student1)
    gradebook.courses[0].enroll(student2)

    student1.log_score(89)
    student1.log_score(78)
    student2.log_score(59)
    student2.log_score(79)

    expect(gradebook.students_below(80)).to eq([student2])

  end
end

# You have been contracted by the University of Denver to write a program that models gradebooks for its courses. Use TDD to implement the following features:

# Create a Gradebook class. Each gradebook has an instructor, as well as a way to read that data.
# Each gradebook has courses, as well as a way to read that data.
# A gradebook can list_all_students in its courses.
# A gradebook can students_below(threwhold) to return a list of students whose grades are below a given threshold.
# Method Name	Return Value (type)
# instructor	String
# courses	Array of Course objects
# add_course(course)	Array of Course objects including the new one just added.
# list_all_students	Hash where the key is a Course object and the value is an Array of Student objects
# students_below(threshold)	Array of Student objects
