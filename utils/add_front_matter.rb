require 'date'

#print name of the file to the console
dir = 'content/'
files = Dir.glob("#{dir}**/*.md")

files.each do |file|
  puts file
end 