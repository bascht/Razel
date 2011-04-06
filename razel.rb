#!/usr/bin/env ruby

require 'fileutils'
require 'yaml'

# Just a little helper to clean up folders

# default config
config = {"folders" => []}
 
# optional config file
configfile = File.expand_path(File.dirname(__FILE__)) + '/config.yaml'
config = YAML.load_file(configfile) if File.exists?(configfile)

# command line arguments
if ARGV.empty?
  folders = config['folders']
else
  folders = ARGV.collect do |rel|
    File.absolute_path(rel)
  end
end

folders.each do |folder|
  Dir.foreach(folder) do |file|
    FileUtils.cd(folder)

    itsnotme = File.basename(__FILE__) != File.basename(file)

    if File.file?(file) && itsnotme
      ext = File.extname(file).downcase
      ext.slice!(0)
      unless ext.empty?
        target_dir = "#{folder}/Razel/#{ext}"
        FileUtils.mkdir(target_dir) unless Dir.exists?(target_dir)
        FileUtils.move(file, "#{target_dir}/#{file}")
      end
    end
  end
end

