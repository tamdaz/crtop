require "./../spec_helper"

describe BCrytop::Functions do
  it "generate a graph to represent the CPU usage" do
    percentages = [0, 25, 50, 75, 100, 75, 50, 25, 0]

    BCrytop::Functions
      .generate_cpu_graph(percentages)
      .should eq("\u28E0\u28F4\u28FE\u28F7\u28E6\u28C4")
  end
end
