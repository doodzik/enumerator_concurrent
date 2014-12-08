require 'minitest/autorun'
require 'enumerator_concurrent/queued'

class EnumeratorConcurrentQueuedTest < Minitest::Test
  def test_map_workers
    cq = EnumeratorConcurrent::Queued.new [1, 2, 3, 4], 2
    assert_equal([2, 4, 6, 8], cq.map { |x| x*2 })
  end

  def test_each_workers
    cq = EnumeratorConcurrent::Queued.new [1, 2, 3, 4], 2
    result = 0
    result1 = cq.each { |x| result += x  }
    assert_equal([1, 2, 3, 4], result1)
    assert_equal(10, result)
  end

  def test_init_workers
    cq = EnumeratorConcurrent::Queued.new [], 2
    result1, result2 = cq.send(:init_workers) {}
    assert result1.is_a? Thread
    assert result2.is_a? Thread
  end
end
