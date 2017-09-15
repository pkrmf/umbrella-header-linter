require 'fileutils'
require 'colorize'
require "umbrellalinter/validator"

module Umbrella
   class XcodeProjParser
   	attr_reader :import_files, :fix, :umbrella_header

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @import_files = options.fetch(:import_files)
      @fix = options.fetch(:fix)
      @umbrella_header = options.fetch(:umbrella_header)
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
          if line.include? "settings = {ATTRIBUTES = (Public"
            filename = line.split(/\/\* (.*?)in Headers \*\//)[1]
            @project_files[filename.chop] =  "Public"
          end
        end
      end
      Umbrella::Validator.new({
        :import_files => @import_files,
        :project_files => @project_files,
        :fix => @fix,
        :project_file_path => project_file_path,
        :umbrella_header => @umbrella_header
      }).validate
    end
  end
end