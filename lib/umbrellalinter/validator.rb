require 'fileutils'
require 'colorize'

module Umbrella
  class Validator
  	attr_reader :project_files, :import_files

  	def self.perform(options)
		new(options).perform
	end

	def initialize(options)
		@import_files = options.fetch(:import_files)
		@project_files = options.fetch(:project_files)
	end

	def validate
		# First we need to validate that all the import files in umbrella header are set as public.
		@import_files.each { |filename|
        	unless @project_files.key?(filename)
          		puts filename.red + " needs to be set as public or your consumers won't be able to import it.".red
        	end
      	}
      	@project_files.each do |filename, scope|
      		unless @import_files.include? filename
      			puts filename.red + "is Public and needs to be added to the umbrella header".red
      		end
		end
	end
  end
end