 @students = [] # create an empty array that is accessible to all methods '@'
  
  def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.delete!("\n")
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "What cohort are they in?"
    month = STDIN.gets.delete!("\n")
    #set a default month if no cohort entered
      if month == ""
        month = "november"
      end
    puts "What is their favourite hobby?"
    hobby = STDIN.gets.delete!("\n")
    # add all student info as a hash into the array
    @students << {name: name, cohort: month.to_sym, hobbies: hobby}
    if @students.length == 1 
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    puts "Next student?"
    name = STDIN.gets.chomp
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu # 1. print the menu and ask the user what to do
    process(STDIN.gets.chomp) # 2. read the input and save it into a variable 
  end
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students 
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # this will cause the program to terminate
    else 
      puts "I don't know what you meant, try again"
  end
end

def print_header
  if !@students.empty?
    puts "The students of Villains Academy".center(50)
    puts "-------------".center(40)
  end
end

def print_student_list
  # set an accumulator so the loop can be broken
  total_names = 0
  # use until loop to print students details until total names matches total number of students
  until total_names == @students.count 
    @students.each.with_index(1) do |student, index|
     puts "#{index}. #{student[:name]} --> cohort: #{student[:cohort]}, hobby: #{student[:hobbies]}".center(50)
     total_names += 1
    end
  end
end

def print_footer
  if @students.length == 0
    puts "Overall, we have no students".center(50)
  elsif @students.length == 1
    puts "Overall, we have #{@students.count} great student".center(50)
  else
    puts "Overall, we have #{@students.count} great students".center(50)
  end
end

def print_first_letter
  puts "What letter would you like to search for?"
  letter = gets.chomp
  @students.each do |student|
    if student[:name][0] == letter
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_names_less_than_12_chars
  @students.each do |student|
    if student[:name].length < 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_grouped_by_cohort
  puts "Select cohort group"
  cohort = gets.chomp.to_sym
  @students.select do |student|
    if student[:cohort] == cohort
      puts "#{student[:name]} --> cohort: #{student[:cohort]}, hobby: #{student[:hobbies]}".center(50)
    end
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobbies]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end 

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort, hobby = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym, hobbies: hobby}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exist?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu
# nothing happens until we call the methods
# print_first_letter(students)
# print_names_less_than_12_chars(students)
# print_grouped_by_cohort(students)
