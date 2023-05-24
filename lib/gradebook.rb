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

  def all_grades
    grades = {}
    @courses.each do |course|
      grades[course] = course.students.map { |student| student.scores }
    end
    grades.transform_values { |scores| scores.flatten }
  end
    
  def students_in_range(range)
    students = []
    @courses.each do |course|
      course.students.each do |student|
        students << student if range.include?(student.grade)
      end
  end
end
