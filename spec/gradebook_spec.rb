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

  it "can list all grades for all courses" do
    gradebook = Gradebook.new("Ron")
    gradebook.add_course(Course.new("Calculus", 2))
    gradebook.add_course(Course.new("Chemistry", 2))

    student1 = Student.new({name: "Morgan", age: 21})
    student2 = Student.new({name: "Jordan", age: 29})
    student3 = Student.new({name: "Eric", age: 4})
    student4 = Student.new({name: "Sarah", age: 20})

    gradebook.courses[0].enroll(student1)
    gradebook.courses[0].enroll(student2)
    gradebook.courses[1].enroll(student3)
    gradebook.courses[1].enroll(student4)

    student1.log_score(89)
    student1.log_score(78)
    student2.log_score(59)
    student2.log_score(79)
    student3.log_score(99)
    student3.log_score(100)
    student4.log_score(72)
    student4.log_score(89)

    expect(gradebook.all_grades).to eq({gradebook.courses[0] => [89, 78, 59, 79], gradebook.courses[1] => [99, 100, 72, 89]})
    
  end

end

# The University of Denver would like you to implement additional functionality. They would like to be able to track all the grades across all courses. They would also like to be able to find all students across all courses that have a grade in a given range.

# Method Name	Return Value (type)
# all_grades	Hash where the key is a Course object and the value is an Array of all the grades for that course.
# students_in_range(min, max)	Array of Student objects
