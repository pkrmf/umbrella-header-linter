 require "thor"
 require "umbrellalinter"

 module Umbrella
   class CLI < Thor
   	desc "lint FrameworkTargetName", "Lints the umbrella header of the Framework"
    option :fix, :type => :boolean
  	def lint(name)
    	Umbrella::Linter.new({
			:framework_target_name => name,
      :fix => options[:fix]
		}).run
  	end
   end
  end