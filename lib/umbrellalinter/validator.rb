require 'fileutils'
require 'colorize'
require 'Xcodeproj'
require 'fileutils'
require 'tempfile'

module Umbrella
  class Validator
  	attr_reader :project_files, :import_files, :fix, :project_file_path, :umbrella_header, :framework_target_name

  	def self.perform(options)
		new(options).perform
	end

	def initialize(options)
		@import_files = options.fetch(:import_files)
		@project_files = options.fetch(:project_files)
		@fix = options.fetch(:fix)
		@project_file_path = options.fetch(:project_file_path)
		@umbrella_header = options.fetch(:umbrella_header)
		@framework_target_name = options.fetch(:framework_target_name)
	end

	def validate 
		xcodeproj_path = ""
		# First we need to validate that all the import files in umbrella header are set as public.
		@import_files.each { |filename|
        	unless @project_files.key?(filename)
        		if @fix
    				t_file = Tempfile.new('filename_temp.txt')
    				File.open(@project_file_path, 'r') do |f|
      					f.each_line{|line|
      						if line.include? filename.chop + " */;"
      							puts "Changing the scope of " + filename.chop + " to" +" Public".green
								newline = line.slice(0..(line.index(filename.chop + " */;")))
								newline = newline + filename.chop + " */;" + " settings = {ATTRIBUTES = (Public, ); }; };"
								t_file.puts newline
      						else 
      							t_file.puts line
      						end
      					}
    				end
    				t_file.close
    				FileUtils.mv(t_file.path, @project_file_path)
        		else
          			puts filename.red + " needs to be set as Public or your consumers won't be able to import it.".red
          		end
        	end
      	}
      	@project_files.each do |filename, scope|
      		unless @import_files.include? filename
      			if @fix
      				unless filename.include? File.basename( umbrella_header )
      					puts "Adding ".green + filename.green + " to Umbrella Header".green
      					File.open(@umbrella_header, 'a') do |f1|  f1.write("\n#import <" + File.basename( umbrella_header, ".*" ) + "/" + filename + ">")
						end
					end
      			else
      				puts filename.red + "is Public and needs to be added to the umbrella header".red
      			end
      		end
		end
	end
  end
end