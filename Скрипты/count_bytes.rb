#TODO: RECREATE

require 'csv'

def compile(shellcodes)
	shellcodes.each do |shellcode|
		file_name = File.basename(shellcode, '.c')
		system("gcc #{shellcode} -w -o shellcodes/output/#{file_name}")
	end

	Dir['shellcodes/output/*']
end

def hist_of_bytes(file_pathes)
	res = Array.new(256, 0)
	file_pathes.each do |file|
		s = File.open(file, 'rb') { |io| io.read }
		s.each_byte do |byte|
			res[byte] += 1
		end
	end
	sum = res.inject(:+)
	res.map { |el| el.to_f / sum }
end

`rm -rf shellcodes/output` if Dir.exist?('shellcodes/output')
shellcodes = Dir['shellcodes/*']
simple_files = Dir['simple/*']
Dir.mkdir('shellcodes/output')
puts "Start compile files..."
compiled_files = compile(shellcodes)

puts 'Start count shellcode hist...'
shellcode_hist = hist_of_bytes(compiled_files)
CSV.open('shellcode_hist.csv', 'w') do |csv|
	shellcode_hist.each do |el|
		csv << [el]
	end
end

puts 'Start count simple files hist...'
simple_hist = hist_of_bytes(simple_files)
CSV.open('simple_hist.csv', 'w') do |csv|
	simple_hist.each do |el|
		csv << [el]
	end
end

diff = []
shellcode_hist.each_with_index do |el, idx|
	diff << el - simple_hist[idx]
end

CSV.open('diff.csv', 'w') do |csv|
	diff.each do |el|
		csv << [el]
	end
end

puts diff.map {|el| el.abs }.max
puts diff.map {|el| el.abs }.min
puts

def count_hist(file_path)
	hist_of_bytes([file_path])
end

csv = CSV.open('table.csv', 'w')
compiled_files.each do |shellcode|
	hist = count_hist(shellcode)
	csv << [1, hist].flatten
end

simple_files.each do |shellcode|
	hist = count_hist(shellcode)
	csv << [2, hist].flatten
end