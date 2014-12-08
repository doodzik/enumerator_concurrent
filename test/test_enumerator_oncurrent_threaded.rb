require 'minitest/autorun'
require 'enumerator_concurrent/threaded'

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
    thread1, thread2 = EnumeratorConcurrent::Threaded.new([2, 3]).each_to_thread do |x|
      x + 10
    end

    assert(thread1.is_a? Thread)
    assert(thread2.is_a? Thread)
    assert_equal(thread1.value, 12)
    assert_equal(thread2.value, 13)
  end

  def test_joining_threads
    threads = [ThreadMock.new, ThreadMock.new]
    t1, t2 = EnumeratorConcurrent::Threaded.new(threads).join_threads
    assert(t1.joined)
    assert(t1.valued)
    assert(t2.joined)
    assert(t2.valued)
  end

  def test_each
    values = [3, 2]
    ec = EnumeratorConcurrent::Threaded.new(values)
    t1, t2 = ec.each { |x| x + 2 }
    assert_equal(t1, 5)
    assert_equal(t2, 4)
  end
end