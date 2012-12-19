module Kmeans
  class CLI
    def initialize(args)
      @args = args
    end

    def num_means
      @args.map {|arg| arg =~ /^--means=(\d+)$/; $1 ? $1.to_i : nil }.compact.first
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
            vectors << Vector[$1.to_f, $2.to_f]
          else 
            $stderr.puts "unknown line format: '#{line}'"
          end
        end
        vectors
      end
    end

    def usage
      puts "USAGE: bin/kmeans --means=N FILE"
      exit 1
    end

    def solver
      usage unless input_path
      usage unless num_means
      puts "Got #{input_vectors.length} vectors"
      puts "Solving for #{num_means} means"
      Kmeans::IterativeSolver.new(num_means, input_vectors)
    end
  end
end
