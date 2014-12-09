require 'minitest/autorun'
require 'enumerator_concurrent'

# test implementation of the lib
class EnumeratorConcurrentTest < Minitest::Test
  def test_extended_array
    assert_equal(EnumeratorConcurrent::Threaded, [].concurrent.class)
    assert_equal([1, 2, 3], [1, 2, 3].concurrent)
  end

  def test_extended_concrrent_with_threads
    cq = EnumeratorConcurrent::Queued.new [1, 2, 3, 4], 2
    assert_equal([1, 2, 3, 4].concurrent.threads(2), cq)
  end
end
