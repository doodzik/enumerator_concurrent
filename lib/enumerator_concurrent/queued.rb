# Namespace
module EnumeratorConcurrent
  # Enumerator with thread count speciyfied to handle loop
  class Queued < Array
    # @param arr [Array]
    # @param thread_count [Int] how many thread should be handle the Enumarator
    def initialize(arr, thread_count)
      @thread_count = 0...thread_count
      @queue = Queue.new
      @arr = arr
      super(arr)
    end

    # @yield [x] element in array
    # @return [self]
    def each
      @arr.each { |x| @queue.push x }
      init_workers do
        pop_queue do |x|
          yield(x)
        end
      end
      self
    end

    # @yield [x] element in self
    # @return [Array] with modified values
    def map
      return_value = []
      @arr.map.with_index { |x, i| @queue.push(i => x) }
      init_workers do
        pop_queue do |x|
          key, value = x.first
          return_value[key] = yield(value)
        end
      end
      return_value
    end

    private

    # @yield run block in specified Thread count
    def init_workers
      to_join = @thread_count.map do
        Thread.new do
          yield
        end
      end
      to_join.map(&:join)
    end

    # @yield [x] poped element from the queue
    def pop_queue
      loop { yield(@queue.pop(true)) }
    rescue ThreadError => e
      p e unless e.message == 'queue empty'
    end
  end
end
