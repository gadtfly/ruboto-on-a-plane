add2 = ",>,[-<+>]<."
addN = "[>,]<[>[-<+>]<<]>." # looks reasonable but ruboto irb keeps crashing: doesn't seem to catch stack overflow; also printing apparently lazy, so debugging impossible

program = addN
input = [5,7,13,0]

language = { '+' => ->{ array[index] += 1 },
             '-' => ->{ array[index] -= 1 },
             '>' => ->{ @index += 1 },
             '<' => ->{ @index -= 1 },
             '[' => ->{ stack << counter },
             ']' => ->{ array[index].zero? ? stack.pop : @counter = stack.last },
             ',' => ->{ array[index] = gets },
             '.' => ->{ puts array[index] } }

class ZeroedArray < Array
  def [](index)
    super(index) || 0
  end
end

class VM
  attr_reader :language, :program, :input
  attr_reader :counter, :stack, :array, :index

  def initialize(language, program, input)
    @language = language
    @program  = program
    @input    = input.to_enum

    @counter = 0
    @stack   = []
    @array   = ZeroedArray.new
    @index   = 0
  end

  def gets
    input.next
  end

  def run!
    instance_exec(&language[program[counter]])
    @counter += 1
    run! unless program[counter].nil?
  end
end

VM.new(language, program, input).run!
