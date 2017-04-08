require 'pp'

def ppd(*arg)
  if $DEBUG
    pp(*arg)
  end
end

def putsd(*arg)
  if $DEBUG
    puts(*arg)
  end
end

def parr(arr)
  puts arr.join(" ")
end

def parrd(arr)
  putsd arr.join(" ")
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  count.times do
    words << readline.chomp
  end
  words
end

class Integer
  def popcount32
    bits = self
    bits = (bits & 0x55555555) + (bits >>  1 & 0x55555555)
    bits = (bits & 0x33333333) + (bits >>  2 & 0x33333333)
    bits = (bits & 0x0f0f0f0f) + (bits >>  4 & 0x0f0f0f0f)
    bits = (bits & 0x00ff00ff) + (bits >>  8 & 0x00ff00ff)
    return (bits & 0x0000ffff) + (bits >> 16 & 0x0000ffff)
  end

  def combination(k)
    self.factorial/(k.factorial*(self-k).factorial)
  end

  def permutation(k)
    self.factorial/(self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

def ok(s)
  a = s.to_s.each_char.to_a
  b = a.sort
  a == b
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  a = rs
  # for a in 1..100
  # case_index = Random.rand(100000000000000000..999999999999999999)
  # a = case_index.to_s

  k = 1
  while !ok(a)
    k += 1 while a[-k] == "9"
    a[-k] = "9"
    for i in k+1..a.size
      if a[-i] == "0"
        a[-i] = "9"
      else
        a[-i] = (a[-i].to_i - 1).to_s
        break
      end
    end
    if a[0] == "0"
      a = a[1..-1]
    end
# ppd a
  end

  puts "Case ##{case_index}: #{a}"

  # progress
  trigger = 
    if cases >= 10
      case_index % (cases / 10) == 0
    else
      true
    end

  if trigger
    STDERR.puts("case #{case_index} / #{cases}, time: #{Time.now - t_start} s")
  end
end
