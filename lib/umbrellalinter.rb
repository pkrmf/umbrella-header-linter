require "umbrellalinter/version"
require "umbrellalinter/cli"

module Umbrella
  class Linter
  	attr_reader :framework_target_name

  	def self.perform(options)
		new(options).perform
	end

	def initialize(options)
			@framework_target_name = options.fetch(:framework_target_name)
	end

	def run
		# The directories containing the umbrella header(should only be 1, so we will take the last).
		directories = Dir.glob("./**/" + @framework_target_name + ".h")
	 	file = File.read(directories.last)
	 	puts directories
	end
  end
end