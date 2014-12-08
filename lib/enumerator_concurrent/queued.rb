
module EnumeratorConcurrent
  class Queued < Array
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
end
