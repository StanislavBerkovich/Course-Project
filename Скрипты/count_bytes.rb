# encoding: utf-8

require 'csv'

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

VIRUSES_PATH = '/home/stas/Coursach/Выборки/compiled/viruses'
NORMAL_PATH = '/home/stas/Coursach/Выборки/compiled/normal'
REPORT_PATH = '/home/stas/Coursach/Отчеты'


shellcodes = Dir["#{VIRUSES_PATH}/*"]
simple_files = Dir["#{NORMAL_PATH}/*"]

puts 'Start count shellcode hist...'
shellcode_hist = hist_of_bytes(shellcodes)
CSV.open("#{REPORT_PATH}/viruses_hist.csv", 'w') do |csv|
	shellcode_hist.each do |el|
		csv << [el]
	end
end

puts 'Start count simple files hist...'
simple_hist = hist_of_bytes(simple_files)
CSV.open("#{REPORT_PATH}/normal_hist.csv", 'w') do |csv|
	simple_hist.each do |el|
		csv << [el]
	end
end

diff = []
shellcode_hist.each_with_index do |el, idx|
	diff << el - simple_hist[idx]
end

CSV.open("#{REPORT_PATH}/byte_diff.csv", 'w') do |csv|
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

csv = CSV.open("#{REPORT_PATH}/count_bytes_table.csv", 'w')
shellcodes.each do |shellcode|
	hist = count_hist(shellcode)
	csv << [1, hist].flatten
end

simple_files.each do |shellcode|
	hist = count_hist(shellcode)
	csv << [2, hist].flatten
end