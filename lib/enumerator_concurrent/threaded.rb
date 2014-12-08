# Implements a Concurrent Each

module EnumeratorConcurrent
  class Threaded < Array
    # @param &block [Block] takes a block an passes it to each_to_thread
    # @return [Array] as the standard each does
    def each(&block)
      each_to_thread(&block).join_threads
    end

    # joins a list of threads and returns the threads value
    # @return [Array<thread.join.value>]
    def join_threads
      Threaded.new map { |x| x.join.value }
    end

    # initializes for every iteration a new Thread
    # @return [Array<thread>] Array of Thread instances
    def each_to_thread
      Threaded.new map { |x| Thread.new { yield(x) } }
    end

    # @param thread_workers [Int] number of threads running. defaults to four
    # @return [Enumerator::ConcurrentQueue]
    def threads(thread_workers)
      Queued.new self, thread_workers
    end
  end
end
