require 'date'
require 'find'

dir = 'content/'
# files = Dir.glob("#{dir}**/*.md")
# files.each do |file|
#   puts file
# end 

#add front matter to each file
def generate_front_matter(file_name, summary, description)
  title = file_name.gsub(/[-_]/, ' ').gsub('.md', '').capitalize
  date = Date.today.strftime("%Y-%m-%d")
  draft = "false"
  summary = "#{summary}"
  description = "#{description}"
  authorimage =  "../assets/images/site-logo.png"
  front_matter = <<~FRONT_MATTER
  ---
  title: "#{title}"
  date: "#{date}"
  draft: "#{draft}"
  summary: "#{summary}"
  description: "#{description}"
  tags: "Blog"
  author: "Maestro Taquero"
  authorimage: "../assets/images/site-logo.png"
  categories: "Blog"
  ---
  FRONT_MATTER
  front_matter
end

Find.find(dir) do |file_path|
  next unless file_path.end_with?('.md')

  file_name = File.basename(file_path)
  content = File.read(file_path)

  summary = nil
  description = nil

  content.each_line do |line|
    if line.start_with?('## ')
      summary = line[3..-1].strip

      description_lines = []

      description_lines << summary

      content.each_line do |desc_line|
        break if desc_line.start_with?('# ') || desc_line.start_with?('## ') || desc_line.strip.empty?
        description_lines << desc_line.strip unless desc_line.strip.empty?
      end

      description = description_lines.join(' ')
      break
    end
  end

  summary ||= 'No hay resumen'
  description ||= 'No hay descripción'

  unless content.start_with?('---')
    front_matter = generate_front_matter(file_name, summary, description)
    File.open(file_path, 'w') do |file|
      file.write(front_matter + content)
    end
    puts "Added front matter to #{file_name}"
  end


  # front_matter = generate_front_matter(file_name, summary, description)
  # puts front_matter
end





# result = generate_front_matter("Director_de_Tecnologia_e_inovacion.md")
# puts result