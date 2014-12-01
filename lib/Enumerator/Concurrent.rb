require "Enumerator/Concurrent/version"

class Enumerator::Concurrent < Array

  def each(&block)
    each_to_thread(&block).join_threads
  end

  def join_threads
    Enumerator::Concurrent.new map { |x| x.join.value }
  end

  def each_to_thread 
    Enumerator::Concurrent.new map { |x| Thread.new { yield(x) } }
  end

end

a = %q{def concurrent() Enumerator::Concurrent.new(self) end}
Array.module_eval(a)
a = nil
