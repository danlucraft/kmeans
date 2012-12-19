
module Kmeans
  class CLI
    def initialize(args)
      @args = args
      unless input_path
        puts "USAGE bin/kmeans FILE"
        exit 1
      end
    end

    def input_path
      @args.detect {|arg| File.exist?(arg) && File.file?(arg) }
    end

    def input_vectors
    end

    def run
    end
  end
end
