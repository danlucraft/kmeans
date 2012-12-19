
module Kmeans
  class IterativeSolver
    attr_reader :clusters, :data, :k

    class Cluster
      attr_reader :mean, :values

      def initialize(mean)
        @mean = mean
        @values = []
      end

      def observed_mean
        if @values.length == 0
          @mean
        else
          @observed_mean ||= @values.inject {|m,o| m + o }/@values.length.to_f
        end
      end

      def add(value)
        @values << value
      end
    end

    def initialize(k, data)
      @k, @data = k, data
      initialize_clusters
    end

    def initialize_clusters
      @clusters = random_values(k).map {|m| Cluster.new(m) }
      assign
    end

    def means
      @clusters.map(&:mean)
    end

    def random_values(n)
      @data.shuffle[0...n]
    end

    def signature
      clusters.map {|c| c.observed_mean }.sort_by(&:magnitude)
    end

    # returns true if the assignments didn't change during the update
    def iterate
      prev_sig = signature
      @clusters = clusters.map {|c| Cluster.new(c.observed_mean) }
      assign
      prev_sig == signature
    end

    def stabilize_means
      true until iterate
    end

    def assign
      @data.each do |value|
        cluster = clusters.sort_by { |cluster| (value - cluster.mean).magnitude }.first
        cluster.add(value)
      end
    end
  end
end
