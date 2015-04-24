program = ",[.-]"

$input = [5].to_enum

language = {
  '+' => ->{ a[i] += 1 },
  '-' => ->{ a[i] -= 1 },
  '>' => ->{ @i += 1 },
  '<' => ->{ @i -= 1 },
  '[' => ->{ s << c },
  ']' => ->{ a[i].zero? ? s.pop : @c = s.last },
  ',' => ->{ a[i] = gets },
  '.' => ->{ puts a[i] }
}

module SpoofedGets
  def gets
    $input.next
  end
end

class ZeroedArray < Array
  def [](i)
    super(i) || 0
  end
end

# Sorry about shitty variable names.
# Written on a phone while travelling
# as an exercise deliberately meant
# to reminisce about TI-BASIC.
class VM
  include SpoofedGets
  attr_accessor :l, :p, :c, :s, :a, :i
  
  def initialize(l, p)
    @l = l
    @p = p
    @c = 0
    @s = []
    @a = ZeroedArray.new
    @i = 0
  end

  def run!
    instance_exec(&l[p[c]])
    @c += 1
    run! if p[c]
  end
end

VM.new(language, program).run!
