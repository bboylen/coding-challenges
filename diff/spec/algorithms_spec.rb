require_relative "../algorithms"

RSpec.describe Algorithms do
  describe ".longest_common_subsequence" do
    let(:dummy_class) { Class.new { include Algorithms } }
    let(:object) { dummy_class.new }
    subject { lambda { |str1, str2| object.longest_common_subsequence(str1, str2) } }

    it "correctly computes LCS" do
      expect(subject.call("ABCDEF", "ABCDEF")).to eq("ABCDEF")
      expect(subject.call("ABC", "XYZ")).to eq("")
      expect(subject.call("AABCXY", "XYZ")).to eq("XY")
      expect(subject.call("", "")).to eq("")
      expect(subject.call("ABCD", "AC")).to eq("AC")
    end
  end
end
