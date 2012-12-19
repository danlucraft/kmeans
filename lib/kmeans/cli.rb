
module Kmeans
  class CLI
    def initialize(args)
      @args = args
    end

    def input_path
      @args.detect {|arg| File.exist?(arg) && File.file?(arg) }
    end

    FLOAT_MATCHER = /(-?[0-9]+(?:\.[0-9]+)?)/

    def input_vectors
      @input_vectors ||= begin
        lines = File.readlines(input_path)
        vectors = []
        lines.each do |line|
          line = line.chomp
          if line =~ /^#{FLOAT_MATCHER},#{FLOAT_MATCHER}$/
            vectors << [$1.to_f, $2.to_f]
          else 
            $stderr.puts "unknown line format: '#{line}'"
          end
        end
        vectors
      end
    end

    def run
      unless input_path
        puts "USAGE: bin/kmeans FILE"
        exit 1
      end
      puts "Got #{input_vectors.length} vectors"
    end
  end
end
