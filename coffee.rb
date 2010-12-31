class Coffee
  
  COFFEE_STATUS = %w[C O F F E E]
  FOUR_MINUTES = 24
  UPDATE_INTERVAL = FOUR_MINUTES / (COFFEE_STATUS.size + 1)
  
  def initialize
    @coffee_start_time = Time.now
    @coffee_done_time = @coffee_start_time + FOUR_MINUTES
    @count = 0
  end 
  
  def brew
    display_coffee_status until coffee_is_ready?
    notify
  end
  
private
  
  def coffee_is_ready?
    Time.now > @coffee_done_time
  end
  
  def display_coffee_status
    if display_coffee_status? then
      p @count
      print COFFEE_STATUS[@count]
      STDOUT.flush
      @count += 1
    end
  end
  
  def display_coffee_status?
    Time.now > (@coffee_start_time + (UPDATE_INTERVAL * (@count + 1)))
  end
  
  def notify
    STDOUT.flush
    # `say Coffee is ready!`
    print "\n"
    # send some emails
  end
  
end

Coffee.new.brew