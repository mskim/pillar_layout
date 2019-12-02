
class ArticleWorker
  include SuckerPunch::Job

  def perform(path, time_stamp, auto_fit)
    puts "in ArticleWorker"
    puts "path:#{path}"
    if time_stamp && auto_fit
      system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article .  -time_stamp=#{time_stamp} -auto_fit=#{auto_fit}"
    elsif time_stamp
      system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article .  -time_stamp=#{time_stamp}"
    else
      system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
    end
  end
end
