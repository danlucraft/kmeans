
require 'spec_helper'

describe Kmeans::IterativeSolver do

  describe "initial mean picking" do
    before do
      @values = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      solver = Kmeans::IterativeSolver.new(3, @values)
      @means = solver.means
    end

    it "should pick the right number of means" do
      @means.length.should == 3
    end

    it "should pick from the set given" do
      (@means - @values).should be_empty
    end

    it "should choose distinct values" do
      @means.sort.uniq.length.should == @means.length
    end
  end
end
