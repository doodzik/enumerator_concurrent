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

  # @param thread_workers [Int] number of threads running. defaults to four
  # @return [Enumerator::ConcurrentQueue]
  def threads(thread_workers)
    Enumerator::ConcurrentQueue.new self, thread_workers
  end
end

# Keep in mind that the each operation is not structure preserving
class Enumerator::ConcurrentQueue < Array
  # @param arr [Array]
  # @ thread_count
  def initialize(arr, thread_count)
    @thread_count = 0...thread_count
    @queue = Queue.new
    @arr = arr
    super(arr)
  end

  def each
    @arr.each { |x| @queue.push x }
    init_workers do
      begin
        while x = @queue.pop(true)
          yield(x)
        end
      rescue ThreadError
      end
    end.map { |x| x.join }
    self
  end

  def map
    return_value = {}
    @arr.map.with_index { |x, i| @queue.push({ i => x }) }
    init_workers do
      begin
        while x = @queue.pop(true)
          key, value = x.first
          return_value[key] = yield(value)
        end
      rescue ThreadError
      end
    end.map { |x| x.join }
    return_value.values
  end

  private
  # returns
  def init_workers
    @thread_count.map do
      Thread.new do
        yield
      end
    end
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
