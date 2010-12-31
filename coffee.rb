class FrenchPress
  
  COFFEE_STATUS = %w[C O F F E E]
  FOUR_MINUTES = 240
  UPDATE_INTERVAL = FOUR_MINUTES / (COFFEE_STATUS.size + 1)
  
  def initialize
    @status_count = 0
  end 
  
  def brew
    FOUR_MINUTES.times do |seconds_brewing|
      display_coffee_status_after_enough(seconds_brewing)
      sleep 1
    end
    notify
  end
  
private
  
  def display_coffee_status_after_enough(seconds_brewing)
    if display_coffee_status?(seconds_brewing) then
      print COFFEE_STATUS[@status_count]
      STDOUT.flush
      @status_count += 1
    end
  end
  
  def display_coffee_status?(seconds_brewing)
    (@status_count < COFFEE_STATUS.size) && (seconds_brewing >= (UPDATE_INTERVAL * (@status_count + 1)))
  end
  
  def notify
    print "\n"
    `say Coffee is ready!`
    
    # send some emails
  end
  
end