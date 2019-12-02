class PageWorker
  # include Sidekiq::Worker
  include SuckerPunch::Job

   def perform(path, time_stamp)
    puts "in PageWorker"
    puts "path:#{path}"
    if time_stamp      
      system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman section .  -time_stamp=#{time_stamp}"
    else
      system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman section ."
    end
  end
end
