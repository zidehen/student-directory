def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.delete!("\n")
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "What cohort are they in?"
    month = gets.delete!("\n")
    #set a default month if no cohort entered
      if month == ""
        month = "november"
      end
    puts "What is their favourite hobby?"
    hobby = gets.delete!("\n")
    # add all student info as a hash into the array
    students << {name: name, cohort: month.to_sym, hobbies: hobby}
    if students.length == 1 
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    puts "Next student?"
    name = gets.chomp
  end
  # return the array of students 
  students
end

def print_header(students)
  if !students.empty?
    puts "The students of Villains Academy".center(40)
    puts "-------------".center(40)
  end
end

def print(students)
  # set an accumulator so the loop can be broken
  total_names = 0
  # use until loop to print students details until total names matches total number of students
  until total_names == students.count 
    students.each.with_index(1) do |student, index|
     puts "#{index}. #{student[:name]} --> cohort: #{student[:cohort]}, hobby: #{student[:hobbies]}".center(40)
     total_names += 1
    end
  end
end

def print_first_letter(students)
  puts "What letter would you like to search for?"
  letter = gets.chomp
  students.each do |student|
    if student[:name][0] == letter
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_names_less_than_12_chars(students)
  students.each do |student|
    if student[:name].length < 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_grouped_by_cohort(students)
  puts "Select cohort group"
  cohort = gets.chomp.to_sym
  students.select do |student|
    if student[:cohort] == cohort
      puts "#{student[:name]} --> cohort: #{student[:cohort]}, hobby: #{student[:hobbies]}".center(40)
    end
  end
end

def print_footer(students)
  if students.length == 0
    puts "Overall, we have no students".center(40)
  elsif students.length == 1
    puts "Overall, we have #{students.count} great student".center(40)
  else
    puts "Overall, we have #{students.count} great students".center(40)
  end
end

students = input_students
# nothing happens until we call the methods
print_header(students)
print(students)
# print_first_letter(students)
# print_names_less_than_12_chars(students)
print_grouped_by_cohort(students)
print_footer(students)