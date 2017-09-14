require 'fileutils'

module Umbrella
   class XcodeProjParser
   	attr_reader :import_files

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @import_files = options.fetch(:import_files)
      project_files = {}
    end

    def parse
      # The directories containing the umbrella header(should only be 1, so we will take the last).
      directories = Dir.glob("./**/project.pbxproj")
      file = File.read(directories.last)
      put directories
    end
  end
end