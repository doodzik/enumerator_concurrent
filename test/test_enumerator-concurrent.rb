require 'minitest/autorun'
require 'Enumerator/Concurrent'

class ThreadMock
  attr_reader :joined, :valued
  @joined = false
  @value = false

  def join
    @joined = true
    self
  end

  def value
    @valued = true
    self
  end
end

class EnumeratorConcurrentTest < Minitest::Test
  def test_creates_list_of_threads
    thread1, thread2 = Enumerator::Concurrent.new([2, 3]).each_to_thread do |x|
      x + 10
    end

    assert(thread1.is_a? Thread)
    assert(thread2.is_a? Thread)
    assert_equal(thread1.value, 12)
    assert_equal(thread2.value, 13)
  end

  def test_joining_threads
    threads = [ThreadMock.new, ThreadMock.new]
    t1, t2 = Enumerator::Concurrent.new(threads).join_threads
    assert(t1.joined)
    assert(t1.valued)
    assert(t2.joined)
    assert(t2.valued)
  end

  def test_each
    values = [3, 2]
    ec = Enumerator::Concurrent.new(values)
    t1, t2 = ec.each { |x| x + 2 }
    assert_equal(t1, 5)
    assert_equal(t2, 4)
  end

  def test_extended_array
    assert_equal(Enumerator::Concurrent, [].concurrent.class)
    assert_equal([1, 2, 3], [1, 2, 3].concurrent)
  end

  def test_extended_concrrent_with_threads
    cq = Enumerator::ConcurrentQueue.new [1,2,3,4], 2
    assert_equal([1,2,3,4].concurrent.threads(2), cq)
  end

  def test_map_workers
    cq = Enumerator::ConcurrentQueue.new [1, 2, 3, 4], 2
    assert_equal([2, 4, 6, 8], cq.map { |x| x*2 })
  end

  def test_each_workers
    cq = Enumerator::ConcurrentQueue.new [1, 2, 3, 4], 2
    result = 0
    result1 = cq.each { |x| result += x  }
    assert_equal([1, 2, 3, 4], result1)
    assert_equal(10, result)
  end

  def test_init_workers
    cq = Enumerator::ConcurrentQueue.new [], 2
    result1, result2 = cq.send(:init_workers) {}
    assert result1.is_a? Thread
    assert result2.is_a? Thread
  end
end
