
module Kmeans
  class IterativeSolver
    attr_reader :means

    def initialize(k, data)
      @k, @data = k, data
      @means = random_values(k)
    end

    def random_values(n)
      @data.shuffle[0...n]
    end

    def cluster_means
      []
    end
  end
end
