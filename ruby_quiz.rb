require 'csv'
require 'open-uri'
require_relative 'menus'
require_relative 'tests'

def blank
  puts "\e[H\e[2J"    
end

def app_start
  puts "\033[8;45;120t"
  Menus.title()
  if File.exist?('.ruby_quiz_profile')
    name = File.open('.ruby_quiz_profile', "r+")
    puts "Welcome back #{name.readline}".center(100)  
    name.close   
  elsif File.exist?('.ruby_quiz_profile') == false
    puts "You currently do not have a profile.".center(100)
    puts "Would you like to create one?".center(100)
    print "> "; response = gets.chomp;
    if response == "yes" 
      puts "What would you like your username to be?".center(100)
      print "> "; name = gets.chomp;
      profile = File.new('.ruby_quiz_profile', 'w+')   
      profile.write("#{name}")
      profile.write("\n")
      profile.write(Time.now.to_s[0..9])
      profile.close  
      blank() 
      Menus.title() 
    elsif response == "no"
      exit
    else
     blank()   
     puts "Please answer \"yes\" or \"no\"\n".center(100)  
     app_start
    end
  end
  
  Menus.show_options()
  print "> "; response = gets.chomp; 
  if response.downcase == 'keywords' || response.downcase == '1'
    blank()    
    new_test = Tests::KeywordTest.new
    new_test.get_keywords
    new_test.ask_question(new_test.keywords_hash, new_test.keyword_descriptions)
  elsif response.downcase == 'data types' || response.downcase == '2'
    blank() 
    puts "Sorry, that is currently unavailable".center(100)
    app_start
  elsif response.downcase == 'string escape sequences' || response.downcase == '3'
    blank() 
    puts "Sorry, that is currently unavailable".center(100)
    app_start
  elsif response.downcase == 'operators' || response.downcase == '4'
    blank() 
    puts "Sorry, that is currently unavailable".center(100)
    app_start
  elsif response.downcase == 'leaderboards' || response.downcase == '5'
    top_scores()
  elsif response.downcase == 'profile' || response.downcase == '6'
    view_profile    
  elsif response.downcase == 'exit' || response.downcase == 'quit' || response.downcase == '7'
    blank() 
    puts "\nSee you later\n".center(50)
    exit
  else
    blank()    
    puts "\"#{response.capitalize}\" is not one of the available choices.".center(100)  
    app_start
  end

end

def top_scores
  puts "\033[8;45;120t"
  blank() 
  Menus.leaderboards()
  get_scores
  puts ""
  puts "Type \"back\" to go back to main menu."
  print "> "; response = gets.chomp;
  if response.downcase == "back" 
    blank()
    app_start
  else
    top_scores()
  end
end

def get_scores
  url = "https://api.mongohq.com/databases/ruby_quiz_scores/collections/high_scores/documents?_apikey=thf3nrtvadanqxnbx3wa&limit=10&sort=%7Bscore:-1%7D"
  content = open(url)
  info = content.to_a
  stuff = info[0].split(',')
  @names  = [] 
  @scores = []
  @rank = 1
  @place_list = ['st', 'nd', 'rd', 'th']
  @place = ''
  stuff.each do |thing|
    unless thing.include?('_id')
      if thing.include?('name')
        @names.push(thing.gsub(/"name":/, ''))
       elsif thing.include?('score')
        @scores.push(thing.gsub(/"score":/, ''))
      end        
    end
  end
 
 puts "     Name:".rjust(53) + "Score:".rjust(22)
 puts ''
 @names.each_with_index do |name, i|
   if @rank == 1
     @place = @place_list[0]
   elsif @rank == 2
     @place = @place_list[1]
   elsif @rank == 3
     @place = @place_list[2]
   else
     @place = @place_list[3]
   end
      
   puts "#{@rank}#{@place}".rjust(34) + "#{name[0..16].delete("\"")}".rjust(19) + "#{@scores[i].delete("}]")}".rjust(19)
   @rank += 1
 end

  
end

def view_profile
  get_old_keyword_score()
  blank()
  profile = File.open('.ruby_quiz_profile', 'r+')
  user_name    = profile.readline
  date_created = profile.readline
  puts "User Name:    #{user_name.strip}"
  puts "Date Created: #{date_created.strip}"
  puts ''
  puts "Stats:"
  puts "Keywords - Personal Best: #{@old_keyword_score}/380pts"
  puts "Data Types - Personal Best: /380pts"
  puts "String Escapes - Personal Best: /380pts"
  puts "Operators - Personal Best: /380pts"
  puts ''
  puts "1.) Change User Name"
  puts "2.) Delete Profile" 
  puts "3.) Go Back"
  print "> "; response = gets.chomp; 
  
  if response    == "1"
    change_name()
  elsif response == "2"
    delete_profile()
  elsif response == "3"
    blank()
    app_start()
  else
    puts "Please select one of the available choices.".center(100)
    sleep(1)
    view_profile() 
  end    
  profile.close    
end



def change_name
  blank()
  puts "What would you like to change your user name to?".center(100)  
  print "> "; new_name = gets.chomp; 
  profile = File.open('.ruby_quiz_profile', 'r+')
  content = []
  profile.each_line{|l| content.push(l)}
  content[0] = new_name
  profile.truncate(0)
  profile.write(content[0])
  profile.write("\n")
  profile.write(content[1].strip)
  profile.write("\n")
  profile.write(content[2])
  profile.close  
  puts "Name has been Changed!".center(100) 
  sleep(1)
  view_profile()
end


def delete_profile
  puts "Are you sure you want to delete your profile?"  
  print "> "; delete_profile = gets.chomp;
  
  if delete_profile == "yes"
    puts "Really!?"
    print "> "; delete_profile_conf = gets.chomp;    
    if delete_profile_conf == "yes"
      `rm .ruby_quiz_profile`
       blank()
       if File.exist?('.ruby_quiz_profile') == false
         puts "Profile Deleted!".center(100)
       else
         puts "There was a problem deleting your profile..."
       end
       sleep(1)
       app_start()
    elsif delete_profile_conf == "no"
      view_profile()
    else
      delete_profile()
    end    
  elsif delete_profile == "no"
    view_profile()
  else
    puts "Please answer \"yes\" or \"no\" "
    delete_profile()
  end

end

def get_old_keyword_score
  old_score = File.open('.ruby_quiz_profile', 'r+')
  content = []
  old_score.each_line{|l| content.push(l)}
  if content[2] != nil
    @old_keyword_score = content[2].to_i
  end
  old_score.close
end

app_start

