require 'date'

#print name of the file to the console
dir = 'content/'
files = Dir.glob("#{dir}**/*.md")

# files.each do |file|
#   puts file
# end 

#add front matter to each file
def generate_front_matter(file_name)
  title = file_name.gsub(/[-_]/, ' ').gsub('.md', '').capitalize
end

result = generate_front_matter("Director_de_Tecnologia_e_inovacion.md")
puts result