require "Enumerator/Concurrent/version"

class Enumerator::Concurrent
  attr_reader :list
  def initialize(list)
    @list = list
  end

  def each(&block)
    setup(&block).join.list
  end

  def join
    Enumerator::Concurrent.new @list.map { |x| x.join.value }
  end

  private

  def setup
    threads = @list.map do |x|
      Thread.new { yield(x) }
    end
    Enumerator::Concurrent.new threads
  end

end
