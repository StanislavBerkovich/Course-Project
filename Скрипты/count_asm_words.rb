# encoding: utf-8

require 'csv'
require 'set'
require 'pry'

VIRUSES_PATH = '/home/stas/Coursach/Выборки/dissasemblied/viruses'
NORMAL_PATH = '/home/stas/Coursach/Выборки/dissasemblied/normal'
REPORT_PATH = '/home/stas/Coursach/Отчеты'

viruses = Dir["#{VIRUSES_PATH}/*"]
simple_files = Dir["#{NORMAL_PATH}/*"]
$file_results = {}

def create_word_hist(words)
	result = {}
	words.delete_if { |w| w.empty? }
	words.each do |word|
		result[word.to_sym] ||= 0
		result[word.to_sym] += 1
 	end
 	result.each do |k, v|
 		result[k] = v.to_f / words.length
 	end
 	result
end

def create_hist(name, words, klass)
	histogram = create_word_hist(words)
	$file_results[name.to_sym] = [klass, histogram]
end		

[viruses, simple_files].each_with_index do |files, idx|
	puts
	puts idx
	files.sort.each do |file_path|
		filename = File.basename(file_path, '.disasm')
		print filename, ' '
		text = File.open(file_path).read

		text.gsub!(/\n/, " ")
		words = text.split(/[\s,():]/)
		create_hist(filename, words, idx + 1)
	end	
end

words_set = Set.new

$file_results.each do |filename, (klass, file_hist)|
	words_set.merge file_hist.keys
end

words_set = words_set.to_a.sort

csv = CSV.open("#{REPORT_PATH}/count_asm_table.csv", 'w')
csv << ['class', words_set.map(&:to_s)].flatten
$file_results.each do |filename, (klass, file_hist)|
	histogram = []
	words_set.each_with_index do |word, idx|
		histogram[idx] = file_hist[word] || 0.0
	end
	csv << [klass, histogram].flatten
end
