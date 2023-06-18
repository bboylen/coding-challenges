require "debug"
module DiffAlgorithm
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
    lcs = str1.is_a?(String) ? "" : []
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

  def diff(str1, str2)
    lcs = longest_common_subsequence(str1, str2)
    i = 0
    j = 0
    k = 0
    diff = []

    while i < str1.length || j < str2.length
      # Skip common part.
      while i < str1.length && j < str2.length && str1[i] == str2[j] && str1[i] == lcs[k]
        i += 1
        j += 1
        k += 1
      end

      # Output lines from str1 not in str2.
      while i < str1.length && (k >= lcs.length || str1[i] != lcs[k])
        diff << "< #{str1[i]}"
        i += 1
      end

      # Output lines from str2 not in str1.
      while j < str2.length && (k >= lcs.length || str2[j] != lcs[k])
        diff << "> #{str2[j]}"
        j += 1
      end
    end

    diff
  end
end
