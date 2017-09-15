require 'fileutils'
require 'colorize'
require "umbrellalinter/validator"

module Umbrella
   class XcodeProjParser
   	attr_reader :import_files

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @import_files = options.fetch(:import_files)
      @project_files = {}
    end

    def parse
      project_file_path = ""
      Dir["./**/project.pbxproj"].reject{ |f| f['./Pods'] }.each do |filename|
        project_file_path = filename
        break
      end
      IO.readlines(project_file_path).each do |line|
        if line.include? "in Headers"
          @import_files.each { |filename| 
          if line.include? filename 
            if line.include? "settings = {ATTRIBUTES = (Public"
              @project_files[filename] =  "Public"
            end
          end
          }
        end
      end
      Umbrella::Validator.new({
        :import_files => @import_files
        :project_files => @project_files
      }).validate
    end
  end
end