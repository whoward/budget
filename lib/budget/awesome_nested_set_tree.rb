
module Budget
  class AwesomeNestedSetTree
    include Enumerable

    def self.from_nodes(nodes)
      by_id = Hash[nodes.map { |n| [n.id, n] }]

      # TODO: zomg the dirty dirty
      populate = lambda do |n|
        nodes.select { |c| c.parent_id == n.node.id }
        .map do |c|
          x = Container.new(c, n, nil)
          x.children = populate.call(x)
          x
        end
      end

      roots =
        nodes.reject { |n| by_id.keys.include?(n.parent_id) }
        .map do |n|
          x = Container.new(n, nil, nil)
          x.children = populate.call(x)
          x
        end

      new(roots: roots)
    end

    attr_reader :roots

    def initialize(roots: [])
      @roots = roots
    end

    def each
      return to_enum(:each) unless block_given?

      visit = lambda do |n|
        yield n
        n.children.each { |c| yield(c) }
      end

      @roots.each { |n| visit.call(n) }
    end

    Container = Struct.new(:node, :parent, :children) do
      def root?
        parent.nil?
      end

      def leaf?
        children.length == 0
      end

      def ancestors
        result = [self]
        result << result.last.parent while result.last.parent
        result
      end

      def inspect
        type =
          if root?
            'Root'
          elsif leaf?
            'Leaf'
          else
            'Container'
          end

        "<#{type}: (#{children.length} children)>"
      end

      alias_method :to_s, :inspect
      alias_method :to_str, :inspect
    end
  end
end
