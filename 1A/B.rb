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
  n, p_ = ris
  recipe = ris
  paks = []
  n.times do
    paks << ris
  end

  paks.each do |e|
    e.sort!
  end
# ppd n, p_
ppd recipe
ppd paks

  max_serve = []
  paks.each_with_index{|e, i|
    max_serve << e.max.to_i / (recipe[i]*0.9).ceil
  }
ppd max_serve
  max_serve = max_serve.min
ppd max_serve

  total = 0
  for c in 1..max_serve
    suc = 999999999999
    sucss = []
    paks.each_with_index do |e, i|
      sucs = e.select{ |f|
        (recipe[i]*0.9).ceil * c <= f && f <= (recipe[i]*1.1).floor * c
      }
      sucss << sucs

      if sucs.size < suc
        suc = sucs.size
      end
    end

    if suc > 0
      total += suc
      paks.each_with_index do |e, i|
        paks[i] = e - sucss[i]
      end
    end
ppd paks
  end

  puts "Case ##{case_index}: #{total}"

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
