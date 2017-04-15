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
  r, c = ris
  f = rws(r)

  f.map! do |e|
    e.chars
  end
ppd r, c
ppd f

  letters = {}
#   f.each do |r|
#     r.each do |c|
#       letters[c] = [] if c != "?"
#     end
#   end
# ppd letters

  # 横に埋める
  for y in 0...r
    for x in 0...c
      if f[y][x] != "?"
        ch = f[y][x]
        min_x = x
        max_x = x
# ppd ch, x, y
        if x > 0
          x1 = x-1
          while x1 >= 0
# ppd f[y][x1]
            if f[y][x1] == "?"
              f[y][x1] = ch
              min_x = x1
            else
              break
            end
            x1 -= 1
          end
        end

        if x < c-1
          for x1 in x+1..c-1
            if f[y][x1] == "?"
              f[y][x1] = ch
              max_x = x1
            else
              break
            end
          end
        end
        if !letters[ch]
          letters[ch] = [min_x, max_x, y]
        end
ppd letters
ppd f
      end
    end
  end
ppd letters
ppd f

  # 縦に伸ばす
  letters.each do |ch, run|
    min_x, max_x, y = run

    if y > 0
      y1 = y-1
      while y1 >= 0
        if f[y1][min_x..max_x].join("") =~ /^\?+$/
          for x1 in min_x..max_x
            f[y1][x1] = ch
          end
        else
          break
        end
        y1 -= 1
      end
    end

    if y < r-1
      for y1 in y+1..r-1
        if f[y1][min_x..max_x].join("") =~ /^\?+$/
          for x1 in min_x..max_x
            f[y1][x1] = ch
          end
        else
          break
        end
      end
    end
  end
# ppd f

  puts "Case ##{case_index}:"
  f.each do |c|
    puts c.join("")
  end

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
