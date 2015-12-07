require 'pathname'

module ReplaceText
  class Core
    def initialize(target_path = '.')
      @target = Pathname(target_path)

      puts "target path is #{@target.expand_path}"
    end

    def replace!(pattern, replacement)
      puts "#{Regexp.escape(pattern)}, #{replacement}"

      Dir[@target.join('**/*.rb')].each do |path|
        next if FileTest::directory?(path)

        puts "processing to #{path}"

        source = File.read(path)

        source.gsub!(/#{Regexp.escape(pattern)}/, replacement)

        File.open(path, 'w+') {|f| f.write(source) }
      end
    end
  end
end
