module Tests
  class KeywordTest
    attr_reader :keyword_descriptions, :keywords_hash
    
    def get_keywords
      @keywords_array = []
      @keyword_descriptions = []
      @keywords_hash  = {}
      @final_options = {}
      @keyword_score = 0
      @old_keyword_score = 0

      keywords = File.open('keywords.txt', 'r')  
      keywords.each_line do |word|
        @keywords_array.push(word.strip)
      end 

      @keywords_array.each_with_index do |word, index|
        @keywords_hash[word] = index    
      end
      keywords.close

      descriptions = File.open('keywords_desc.csv', 'r')   
      descriptions.each_line do |line|
      @keyword_descriptions.push(line)  
      end
      descriptions.close 
    end                

    def opt_generator(correct, descriptions, names )
      options = descriptions.dup; options.delete(descriptions[names[correct]]) 
      choices = options.sample(3)
      choices.push(descriptions[names[correct]])
      final_choices = choices.shuffle
      letter = 'a'

      final_choices.each do |choice|
        @final_options[choice] = letter
        letter = letter.next
      end

      @final_options.each_key do |option|
        puts "#{@final_options[option]}.)#{option}".delete(',').delete('"').ljust(50)
        puts
      end      
    end

    def ask_question(collection, descriptions)
      get_old_keyword_score() 
       @get_name = File.open('.ruby_quiz_profile', 'r')
       @user_name = @get_name.readline.delete("\u0000").strip()
       @get_name.close     
      collection.each_key do |name|      
        puts "KEYWORDS".ljust(50) + "Current Score: #{@keyword_score.to_s}pts/380pts".rjust(50)
        puts ''
        puts "What best defines the keyword \"#{name}\"?".center(100)
        puts ''
        opt_generator(name, descriptions, collection)
        print "> "; response = gets.chomp

        if response == @final_options[descriptions[collection[name]]]
          puts "\e[H\e[2J"
          puts "That is correct!\n\n".center(100)
          `say correct!`
          puts "+10 points".center(100)
          @keyword_score = @keyword_score + 10
          
          sleep(2)
          puts "\e[H\e[2J"
        elsif response == "quit" || response == "exit"
          sure()          
        else
          puts "Incorrect!\a".center(100)  
          puts "Sorry, the correct answer was \"#{@final_options[descriptions[collection[name]]]}\"".center(100)
          puts ""
          sleep(4)
          puts "\e[H\e[2J"     
        end
        @final_options.clear      
      end 
      save_score()
    end
        
    def sure()
      puts "Are sure you want to quit?"
      print "> "; response = gets.chomp
      if response == "yes"
        blank()
        save_score()       
        app_start()  
      elsif response == "no" 
        blank()         
      else
        puts "Please answer \"yes\" or \"no\""  
        sure()      
      end        
    end
    
    def save_score()
      profile = File.open('.ruby_quiz_profile', 'r+')
      content = []
      profile.each_line{|l| content.push(l)}
      profile.truncate(0)
      profile.seek(0, IO::SEEK_SET)
      profile.write(content[0].strip)
      profile.write("\n")
      profile.write(content[1].strip)
      profile.write("\n")
      if (@keyword_score > @old_keyword_score)
        profile.write(@keyword_score)
      else
        profile.write(@old_keyword_score)
      end
      profile.close  
      blank()
      puts "You scored #{@keyword_score}pts/380pts".center(100)
      if (@keyword_score > @old_keyword_score)
       puts "New Personal High Score!".center(100)
       sleep(2)
       `curl -X POST https://api.mongohq.com/databases/ruby_quiz_scores/collections/high_scores/documents?_apikey=thf3nrtvadanqxnbx3wa -H "Content-Type: application/json" -d '{"document" : {"name" : "#{@user_name.strip}", "score" : #{@keyword_score} }, "safe" : true }'`
      else
       puts "C'mon, you can do better than that.".center(100)
       sleep(2)
      end   
      blank()
      app_start()
    end
  
  end  
    
 
  
  
  class DataTypesTest
  end
  
  class StringEscapeTest
  end
  
  class OperatorsTest
  end
  


end