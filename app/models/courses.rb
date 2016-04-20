require 'courses/base'

module Courses
  module_function

  def current
    Summer2016
  end

  def self.all
    Base.descendants
  end

  def self.find(name)
    course = all.detect { |klass| klass.name.demodulize.downcase == name.downcase }
    course || current
  end
end
