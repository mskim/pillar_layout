# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exist?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

# guard 'rake', :task => 'wire:parse_wire_story_xml' do
#   watch(%r{/wire_source/101_KOR/(.+)/(.+).xml})
# end

# guard 'rake', :task => 'wire:parse_wire_picture_xml' do
#   watch(%r{/wire_source/201_PHOTO_YNA/(.+)/(.+).xml})
# end

# guard 'rake', :task => 'wire:volumn_test' do
#   watch(%r{/(.+).xml$})
# end

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#
guard :shell do
  local = File.dirname(__FILE__)
  watch(/public\/(.*.xml)/) {|m| puts "#{m[0]}" }
  # watch(/public\/wire_source\/(101_KOR.*).xml/) {|m| puts "#{m[0]}" }
  # watch(/(101_KOR.*).xml/) {|m| puts "#{m[0]}"; `cd #{local} && rake wire:parse_wire_story_xml[#{m[0]}]` }
  # watch(/(201_PHOTO_YNA.*).xml/) {|m| puts "#{m[0]}"; `cd #{local} && rake wire:parse_wire_picture_xml[#{m[0]}]` }

# guard :shell do
#   local = File.dirname(__FILE__)
#   watch(/(101_KOR.*).xml/) {|m| puts "#{m[0]}"; `cd #{local} && rake wire:parse_wire_story_xml[#{m[0]}]` }
#   watch(/(201_PHOTO_YNA.*).xml/) {|m| puts "#{m[0]}"; `cd #{local} && rake wire:parse_wire_picture_xml[#{m[0]}]` }
# end

guard 'remote-sync',
	:source => "/User/apple/Development/pillar_layout/public/1/", 
	:destination => "/User/apple/Development/pillar_layout/public/1/", 
	:user => 'apple',
	:remote_address => '211.115.91.212',
	:verbose => true, 
	:cli => "--color", 
	:sync_on_start => true do
  
  watch(%r{^.+\.(.*)$})
end
