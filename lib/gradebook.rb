class Gradebook
  
  attr_reader :instructor,
              :courses

  def initialize(instructor)
    @instructor = instructor
    @courses = []
  end

  def add_course(course)
    @courses << course
  end

  def list_all_students
    list = {}
    @courses.each { |course| list[course] = course.students }
    list
  end

  def students_below(grade)
    students = []
    @courses.each do |course|
      course.students.each do |student|
        students << student if student.grade < grade
      end
    end
    students
  end
    
end
