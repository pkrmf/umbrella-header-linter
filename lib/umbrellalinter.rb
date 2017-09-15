require "umbrellalinter/version"
require "umbrellalinter/cli"
require "umbrellalinter/xcodeprojparser"

module Umbrella
  class Linter
  	attr_reader :framework_target_name, :fix

  	def self.perform(options)
		new(options).perform
	end

	def initialize(options)
		@framework_target_name = options.fetch(:framework_target_name)
		@fix = options.fetch(:fix)
	end

	def run
		# The directories containing the umbrella header(should only be 1, so we will take the last).
		directories = Dir.glob("./**/" + @framework_target_name + ".h")
	 	file = File.read(directories.last)
	 	umbrella_header = directories.last
	 	import_files = []
	 	IO.readlines(umbrella_header).each do |line|
	 		if  line.start_with?("#import <" + framework_target_name + "/")
	 			filename = line.partition("#import <" + framework_target_name + "/").last
	 			#remove last 2 characters(/n and >)
	 			filename = filename.chop
	 			#Add import files to array.
				import_files.push(filename.chop)
	 		end
	 	end
	 	Umbrella::XcodeProjParser.new({
				:import_files => import_files,
				:fix => fix,
				:umbrella_header => umbrella_header,
				:framework_target_name => @framework_target_name
		}).parse
	end
  end
end