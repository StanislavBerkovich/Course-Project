#encoding: utf-8
VIRUSES_PATH = "/home/stas/Coursach/Выборки/Вирусы/*"
BAD_FILES_EXTNAMES = %w(.py .txt .asm)

file_pathes = Dir[VIRUSES_PATH]
file_pathes.each do |file_path|
	extname = File.extname(file_path)
	if BAD_FILES_EXTNAMES.include?(extname)
		File.delete(file_path) 
		puts 'DELETE ' + file_path
	end
end	
