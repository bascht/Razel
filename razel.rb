#!/bin/env ruby

require 'fileutils'

# Just a little helper to clean up folders

folders = ['/insert/your', '/messy/folders']

folders.each do |folder|
  Dir.foreach(folder) do |file|
    FileUtils.cd(folder)

    itsnotme = File.basename(__FILE__) != File.basename(file)

    if File.file?(file) && itsnotme
      ext = File.extname(file).downcase
      ext.slice!(0)
      unless ext.empty?
        FileUtils.mkdir(ext) unless Dir.exists?(ext)
        FileUtils.move(file, "#{folder}/#{ext}/#{file}")
      end
    end
  end
end

