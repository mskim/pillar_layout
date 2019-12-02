namespace :wire do
  
  desc 'load new ytn contents'
  task :new_ytn_101 => [:environment] do
    puts "in new_ytn task..."
    # WireServiceWorker.perform_async
    # YNewsML.new_ytn
    YNewsML.ytn_101
  end

  desc 'load new ytn contents'
  task :new_ytn_201 => [:environment] do
    puts "in new_ytn task..."
    # WireServiceWorker.perform_async
    YNewsML.ytn_201
  end

  desc 'load new ytn contents'
  task :new_ytn_202 => [:environment] do
    puts "in new_ytn task..."
    # WireServiceWorker.perform_async
    YNewsML.ytn_202
  end

  desc 'load new ytn contents'
  task :new_ytn_203 => [:environment] do
    puts "in new_ytn task..."
    # WireServiceWorker.perform_async
    YNewsML.ytn_203
  end

  desc 'load new ytn contents'
  task :new_ytn_205 => [:environment] do
    puts "in new_ytn task..."
    # WireServiceWorker.perform_async
    YNewsML.ytn_205
  end

  desc 'load new ytn contents'
  task :new_ytn_401 => [:environment] do
    puts "in new_ytn task..."
    # WireServiceWorker.perform_async
    YNewsML.ytn_401
  end

  desc 'testing for mounted volumn file change'
  task :volumn_test, [:paths] => [:environment] do |t, args|
    puts "+++++++ testing files change in mounted volumn:#{args.paths}"
    puts "#{Rails.root}"
  end

  desc 'parse wire story xml'
  task :parse_wire_story_xml, [:paths] => [:environment] do |t, args|
    require "#{Rails.root}" + '/config/environment'
    puts " YhArticle.count:#{ YhArticle.count}"
    YNewsML.parse_new_story_xml(args.paths)
  end

  desc 'parse wire picture xml'
  task :parse_wire_picture_xml, [:paths] => [:environment] do |t, args|
    require "#{Rails.root}" + '/config/environment'
    YNewsML.parse_new_picture_xml(args.paths)
  end
end
