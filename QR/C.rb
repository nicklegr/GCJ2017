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

  runs = Hash.new(0)
  runs[n] = 1

  last_min, last_max = [-1, -1]

  loop do
    sum = runs.values.inject(:+)
    if sum < k
      k -= sum
    else
      arr = runs.keys.sort.reverse
      run =
        if arr.size == 1
          arr[0]
        else
          raise if arr.size != 2
          if k <= runs[arr[0]]
            arr[0]
          else
            arr[1]
          end
        end

      if (run & 1) != 0
        last_min = run / 2
        last_max = run / 2
      else
        last_min = run / 2 - 1
        last_max = run / 2
      end

      break
    end

    step = Hash.new(0)

    runs.keys.each do |j|
      if j == 1
        0
      elsif j == 2
        step[1] += runs[j]
      elsif (j & 1) != 0
        step[j/2] += runs[j] * 2
      else
        step[j/2] += runs[j]
        step[j/2-1] += runs[j]
      end
    end

    runs = step
ppd runs
  end

  puts "Case ##{case_index}: #{last_max} #{last_min}"

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
