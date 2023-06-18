require_relative "../diff_algorithm"

RSpec.describe DiffAlgorithm do
  let(:dummy_class) { Class.new { include DiffAlgorithm } }
  let(:object) { dummy_class.new }
  describe ".longest_common_subsequence" do
    subject { lambda { |str1, str2| object.longest_common_subsequence(str1, str2) } }

    it "correctly computes LCS when inputs are strings" do
      expect(subject.call("ABCDEF", "ABCDEF")).to eq("ABCDEF")
      expect(subject.call("ABC", "XYZ")).to eq("")
      expect(subject.call("AABCXY", "XYZ")).to eq("XY")
      expect(subject.call("", "")).to eq("")
      expect(subject.call("ABCD", "AC")).to eq("AC")
    end

    it "correctly computes LCS when inputs are arrays of strings" do
      expect(subject.call(["have"], ["have"])).to eq(["have"])
      expect(subject.call([""], [""])).to eq([""])
      expect(subject.call(["This is a test which contains:", "this is the lcs"],
        ["this is the lcs", "we're testing"]))
        .to eq(["this is the lcs"])
      expect(subject.call(["Coding Challenges helps you become a better software engineer through
        that build real applications.",
        "I share a weekly coding challenge aimed at helping software engineers level up their skills through deliberate practice.",
        "I’ve used or am using these coding challenges as exercise
        to learn a new programming language or technology.",
        "Each challenge will have you writing a full application or tool. Most of which will be based on real world tools and utilities."],
        ["Helping you become a better software engineer through
          coding challenges that build real applications.",
          "I share a weekly coding challenge aimed at helping software engineers level up their skills through deliberate practice.",
          "These are challenges that I’ve used or am using as exercises
          to learn a new programming language or technology.",
          "Each challenge will have you writing a full application or tool. Most of which will be based on real world tools and utilities."]))
        .to eq(["I share a weekly coding challenge aimed at helping software engineers level up their skills through deliberate practice.",
          "Each challenge will have you writing a full application or tool. Most of which will be based on real world tools and utilities."])
    end
  end

  describe ".diff" do
    subject { lambda { |str1, str2| object.diff(str1, str2) } }

    it "correctly computes diff" do
      expect(subject.call(["a",
        "b",
        "c",
        "d"],
        ["a",
          "b",
          "e",
          "d"]))
        .to eq(["< c", "> e"])

      expect(subject.call(["a",
        "a",
        "a",
        "d"],
        ["a",
          "b",
          "a",
          "a"]))
        .to eq(["> b", "< d"])
    end
  end
end
