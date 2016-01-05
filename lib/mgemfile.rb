require "mgemfile/version"
module Mgemfile
  class GemFileHandler
    attr_reader :current_Gemfile_path

    def initialize
      @current_Gemfile_path = "#{Dir.pwd}/Gemfile"
      initialize_Gemfile
    end

    def help
      path_to_module = %x[gem path mgemfile]
      path_to_lib = /.+lib/.match(path_to_module)
      yaml_help_path = "#{path_to_lib}/help.yaml"
      data_help =  YAML.load_file(yaml_help_path)
      data_help.each do |key,val|
        puts "#{key} #{val}"
      end
    end
    def add_gems gems
      gem_file_iterator gems do |gems|
        gems.each do |gem|
          add_gem(gem)
        end
      end
    end

    def add_grouped_gems gems,options
      gem_file_iterator gems do |gems|
        option = ""
        options.keys.each do |group|
          option << ":#{group},"
        end
        option = option[0...-1]
        full_group  = ""
        gems.each {|gem| full_group << "\n  gem \"#{gem}\""}
        File.open("Gemfile","a+") do |i|
          i.write("\ngroup #{option} do\n#{full_group}\nend")
        end
      end
    end





    private
    def initialize_Gemfile
      create_Gemfile
      add_source
    end

    def create_Gemfile
      #system "touch 'Gemfile'"
      FileUtils.touch 'Gemfile' unless File.exist?("#{current_Gemfile_path}/Gemfile")
    end
    def add_source  site="https://rubygems.org/"
      gemHandler =  File.open(current_Gemfile_path,"a+")
      gemHandler.write("source \"#{site}\"\n") unless sourced?
      gemHandler.close
    end

    def sourced?
      sourced =  nil
      lines = File.open(current_Gemfile_path).read
      lines.each_line do |line|
        sourced  ||= source_exists_in?(line)
      end
      sourced
    end

    def source_exists_in? line
      true unless (/^[\w\s]*source\s*\"(https?):\/\/rubygems\.org\/?\s*\"/.match(line.to_s).nil?)
    end
    def lines
      File.open("Gemfile").read
    end

    def gem_file_iterator gems
      gems_to_install = []
      gems.each do |gem|
        exist =  nil
        lines.each_line do |line|
          exist ||= true unless (/#{gem}/.match(line).nil?)
        end
        gems_to_install << gem  unless exist
      end
        unless gems_to_install.count  == 0
        yield(gems_to_install)
        system "bundle install"
      else
        puts "=====Gem(s) #{gems} already exist(s) in Gemfile====="
      end
    end
    #Will be refactoed to add_gems gems method.
    def add_gem(gem)
      File.open("Gemfile","a+") do |i|
        i.write("\ngem '#{gem}'")
      end
    end
  end
end
