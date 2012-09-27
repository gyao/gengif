#!/usr/bin/env ruby

require 'optparse'
require 'RMagick'
include Magick

options = {}
option_parser = OptionParser.new do |opts|
	opts.banner = 'Help message of gengif.'

	options[:output] = false
	opts.on('-o FILE', '--output FILE', 'Output file name, defaults to a.gif if not set') do |value|
		options[:output] = value
	end

	options[:inputs] = false
	opts.on('-i image_files', '--inputs image_files', Array, 'List of image files to generate gif animation') do |value|
		options[:inputs] = value
	end

	options[:interval] = false
	opts.on('-d number', '--delay number', 'Number of ticks per second, defaults to 10 if not set') do |value|
		options[:interval] = value
	end
end.parse!
# puts options.inspect

Kernel.exit(-1) unless options[:inputs]

animation = ImageList.new(*Dir.glob(options[:inputs], 0))
animation.delay = options[:interval] || 10
animation.write(options[:output] || "a.gif")
