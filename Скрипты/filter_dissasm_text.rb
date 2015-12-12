# encoding: utf-8

DISSASEMBLIED_PATH = "/home/stas/Coursach/Выборки/dissasemblied/normal"
DISSASEMBLIED_TEXT_PATH = "/home/stas/Coursach/Выборки/dissasemblied_text/normal"
REGEXP = /^(?<first>.*:\s+)(?<sec>(\S{2}\s)+)(?<asm_part>.+)$/


file_pathes = Dir["#{DISSASEMBLIED_TEXT_PATH}/*.dissasmtxt"]
file_pathes.each do |file_path|
	filename = File.basename(file_path, '.dissasmtxt')

	asm_code = []
	text = File.open(file_path).read
	text.gsub!(/\r\n?/, "\n")
	text.gsub!(/\t/, "  ")

	text.each_line do |line|
		if res = REGEXP.match(line)
			asm_part = res[:asm_part]
			asm_code << asm_part.strip
		end
	end

	File.open("#{DISSASEMBLIED_PATH}/#{filename}.disasm", 'w+') { |f|
		asm_code.each do |line|
			f.puts line
		end
	}
end

