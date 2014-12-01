require 'Enumerator/Concurrent/version'

# Implements a Concurrent Each
class Enumerator::Concurrent < Array
  # @param &block [Block] takes a block an passes it to each_to_thread
  # @return [Array] as the standard each does
  def each(&block)
    each_to_thread(&block).join_threads
  end

  # joins a list of threads and returns the threads value
  # @return [Array<thread.join.value>]
  def join_threads
    Enumerator::Concurrent.new map { |x| x.join.value }
  end

  # initializes for every iteration a new Thread
  # @return [Array<thread>] Array of Thread instances
  def each_to_thread
    Enumerator::Concurrent.new map { |x| Thread.new { yield(x) } }
  end
end

# opens Array class and adds concurrent method
class Array
  # @return [Enumerator::Concurrent] instance of Enumerator::Concurrent
  #     initialized with self
  def concurrent
    Enumerator::Concurrent.new(self)
  end
end
