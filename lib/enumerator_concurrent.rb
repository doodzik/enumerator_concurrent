require 'enumerator_concurrent/version'
require 'enumerator_concurrent/threaded'
require 'enumerator_concurrent/queued'

# opens Array class and adds concurrent method
class Array
  # @return [Enumerator::Concurrent] instance of Enumerator::Concurrent
  #     initialized with self
  def concurrent
    EnumeratorConcurrent::Threaded.new(self)
  end
end
