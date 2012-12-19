
require 'spec_helper'

describe Kmeans::IterativeSolver do

  before do
    @values = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @solver = Kmeans::IterativeSolver.new(3, @values)
    @means = @solver.means
  end

  describe "initial cluster picking" do

    it "should pick the right number of means" do
      @means.length.should == 3
    end

    it "should pick means from the set given" do
      (@means - @values).should be_empty
    end

    it "should choose distinct means" do
      @means.sort.uniq.length.should == @means.length
    end

    it "should assign all data to clusters" do
      @solver.clusters.map(&:values).flatten.sort.should == @values
    end
  end
end
