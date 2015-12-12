# encoding: utf-8

COMPILED_PATH = "/home/stas/Coursach/Выборки/compiled/normal"

DISSASEMBLIED_PATH = "/home/stas/Coursach/Выборки/dissasemblied_text/normal"

file_pathes = Dir["#{COMPILED_PATH}/*"]
file_pathes.each do |file_path|
	name = File.basename(file_path)
	system("objdump -D #{file_path} > #{DISSASEMBLIED_PATH}/#{name}.dissasmtxt")
end
