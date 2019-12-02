
path = File.dirname(__FILE__)
rjob="/Applications/newsman.app/Contents/MacOS/newsman rjob"
Dir.glob("#{path}/*.rb").each do |rb_file|
  next if rb_file =~ /generate/
  system "cd #{path} && #{rjob} #{rb_file} -jpg"
end
