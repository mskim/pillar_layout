module Movement
  extend ActiveSupport::Concern
  BIG_STEP    = 100
  SMALL_STEP  = 5

  def toggle_selected
    if selected
      update(selected:false)
    else
      update(selected:true)
    end
  end
  
  def move_up(options={})
    if options[:big_step]
      update(y: y - BIG_STEP)
    else
      update(y: y - SMALL_STEP)
    end
  end

  def move_down(options={})
    if options[:big_step]
      update(y: y + BIG_STEP)
    else
      update(y: y + SMALL_STEP)
    end
  end

  def move_left(options={})
    if options[:big_step]
      update(x: x - BIG_STEP)
    else
      update(x: x - SMALL_STEP)
    end
  end

  def move_right(options={})
    if options[:big_step]
      update(x: x + BIG_STEP)
    else
      update(x: x + SMALL_STEP)
    end
  end

  def grow_up(options={})
    if options[:big_step]
      update(y: y - BIG_STEP, height: height + BIG_STEP)
    else
      update(y: y - SMALL_STEP, height: height + SMALL_STEP)
    end
  end

  def grow_down(options={})
    if options[:big_step]
      update(height: height + BIG_STEP)
    else
      update(height: height + SMALL_STEP)
    end
  end

  def grow_left(options={})
    if options[:big_step]
      update(x: x - BIG_STEP, width: width + BIG_STEP)
    else
      update(x: x - SMALL_STEP, width: width + SMALL_STEP)
    end
  end

  def grow_right(options={})
    if options[:big_step]
      update(width: width + BIG_STEP)
    else
      update(width: width + SMALL_STEP)
    end
  end
end