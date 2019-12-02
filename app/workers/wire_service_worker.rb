class WireServiceWorker
  # include Sidekiq::Worker
  include SuckerPunch::Job
  # workers 4
  # max_jobs 10

  def perform
    puts "in perform of WireServiceWorker ..."
    YNewsML.new_ytn
  end
end