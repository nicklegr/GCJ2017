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
  c, j = ris

  cs = []
  js = []
  c.times do
    cs << ris
  end
  j.times do
    js << ris
  end

  acts = cs.map {|e| [e[0], e[1], "C"] }
  acts += js.map {|e| [e[0], e[1], "J"] }

  acts.sort_by!{|e| e[0]}

# ppd acts
  if acts.size == 2 && acts[0][1] != acts[1][0]
    acts = [ acts[0], [acts[0][1], acts[1][0], "_"], acts[1] ]
  end

  if acts.first[0] != 0
    acts = [[0, acts[0][0], "_"]] + acts
  end

  if acts.last[1] != 1440
    acts = acts + [[acts.last[1], 1440, "_"]]
  end

ppd acts

  min = 99999
  for i in 0 ... (1 << acts.size) # 0:C 1:J
    ok = true
    tc = tj = 0
    acts.each_with_index do |e, j|
      v = (i >> j) & 1
      ok = false if v == 0 && e[2] == "C"
      ok = false if v == 1 && e[2] == "J"
      tc += e[1] - e[0] if v == 0
      tj += e[1] - e[0] if v == 1
    end
    next if !ok
    next if tc > 720 || tj > 720

    ex = 0
    for j in 0...acts.size-1
      p1 = (i >> j) & 1
      p2 = (i >> (j+1)) & 1
      ex += 1 if p1 != p2
    end
    ex += 1 if (i & 1) != ((i >> (acts.size-1)) & 1)

    if ex < min
      min = ex
    end
  end

  puts "Case ##{case_index}: #{min}"

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
