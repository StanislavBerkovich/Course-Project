# encoding: utf-8
COMPILED_PATH = "/home/stas/Coursach/Выборки/compiled/viruses"
PATH = "/home/stas/Coursach/Выборки/Вирусы"

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text)
 colorize(text, 31)
end
def green(text)
 colorize(text, 32)
end

file_pathes = Dir["#{PATH}/*.c"]
report = []
file_pathes.each do |file_path|
	name = File.basename(file_path, '.c')
	if system("gcc -w -o #{COMPILED_PATH}/#{name} #{file_path}")
		report << green("OK: #{name}")
	else
	    report << red("FAILED: #{name}")
	end   	
	puts 
	puts
end

report.sort.each do |rep|
	puts rep	
end	
