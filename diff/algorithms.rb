module Algorithms
  def longest_common_subsequence(str1, str2)
    dp = Array.new(str1.length + 1) { Array.new(str2.length + 1, 0) }
    (str1.length - 1).downto(0) do |i|
      (str2.length - 1).downto(0) do |j|
        dp[i][j] = if str1[i] == str2[j]
          1 + dp[i + 1][j + 1]
        else
          [dp[i][j + 1], dp[i + 1][j]].max
        end
      end
    end

    # Backtrack to find the LCS string
    lcs = ""
    i = 0
    j = 0

    while i < str1.length && j < str2.length
      if str1[i] == str2[j]
        lcs << str1[i]
        i += 1
        j += 1
      elsif dp[i + 1][j] > dp[i][j + 1]
        i += 1
      else
        j += 1
      end
    end

    lcs
  end
end
