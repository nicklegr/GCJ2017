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

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  n, k = ris

  # Ri, Hi, R*H
  cakes = []
  n.times do
    e = ris
    e << (e[0] * e[1])
    cakes << e
  end

  cakes.sort_by! do |e|
    e[2]
  end
  cakes.reverse!

ppd cakes

  max = 0
  for bot in 0...n
    # 表面積
    v = Math::PI * (cakes[bot][0] ** 2)
    v += 2 * Math::PI * cakes[bot][2]

    c = 1
    rhs = 0
    cur_r = cakes[bot][0]
    for i in 0...n
      next if bot == i
      break if c >= k
      if cakes[i][0] <= cur_r
        rhs += cakes[i][2]
        c += 1
        cur_r = cakes[i][0]
      end
    end

    v += 2 * Math::PI * rhs

    if max < v
      max = v
    end
  end

  puts "Case ##{case_index}: #{max}"

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
