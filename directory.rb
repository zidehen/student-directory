 @students = [] # create an empty array that is accessible to all methods '@'
  
  def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.delete!("\n")
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "What cohort are they in?"
    cohort = STDIN.gets.delete!("\n")
    #set a default month if no cohort entered
      if cohort == ""
        cohort = "november"
      end
    puts "What is their favourite hobby?"
    hobby = STDIN.gets.delete!("\n")
    # add all student info as a hash into the array
    # @students << {name: name, cohort: month.to_sym, hobbies: hobby}
    student_data(name, cohort, hobby)
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

def student_data(name, cohort, hobby)
  @students << {name: name, cohort: cohort.to_sym, hobbies: hobby}
end

def menu_options
  { 1 => ["Input the students"],
    2 => ["Show the students"],
    3 => ["Save the list to students.csv"],
    4 => ["Load the list from students.csv"],
    9 => ["Exit"]
  }
end 

def print_menu
  menu_options.each do |number, menu|
    puts "#{number}. #{menu[0]}"
  end
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
      puts "You have chosen to input students."
      input_students
    when "2"
      puts "You have chosen to show students."
      show_students 
    when "3"
       puts "Your list has been saved to file."
       save_students
    when "4"
      puts "Your list has been loaded to file."
      load_students
    when "9"
      puts "You have chosen to exit the program."
      exit # this will cause the program to terminate
    else 
      puts "I don't know what you meant, try again"
  end
end

def print_header
  if !@students.empty?
    puts "The students of Villains Academy"
    puts "-------------"
  end
end

def print_student_list
  # set an accumulator so the loop can be broken
  total_names = 0
  # use until loop to print students details until total names matches total number of students
  until total_names == @students.count 
    @students.each.with_index(1) do |student, index|
     puts "#{index}. #{student[:name]} --> cohort: #{student[:cohort]}, hobby: #{student[:hobbies]}"
     total_names += 1
    end
  end
end

def print_footer
  if @students.length == 0
    puts "Overall, we have no students"
  elsif @students.length == 1
    puts "Overall, we have #{@students.count} great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

def save_students
  # open the file for writing
  File.open("students.csv", "w") do |file|
    # iterate over the array of students
    @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobbies]]
    csv_line = student_data.join(",")
    file.puts csv_line
    end
  end
end 

def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort, hobby = line.chomp.split(',')
      student_data(name, cohort, hobby)
      # @students << {name: name, cohort: cohort.to_sym, hobbies: hobby}
    end
  end
end

def try_load_students
  filename = ARGV.first # || "students.csv" # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exist?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def print_first_letter
  puts "What letter would you like to search for?"
  letter = STDIN.gets.chomp
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
  cohort = STDIN.gets.chomp.to_sym
  @students.select do |student|
    if student[:cohort] == cohort
      puts "#{student[:name]} --> cohort: #{student[:cohort]}, hobby: #{student[:hobbies]}"
    end
  end
end

try_load_students
interactive_menu
# nothing happens until we call the methods
# print_first_letter(students)
# print_names_less_than_12_chars(students)
# print_grouped_by_cohort(students)
