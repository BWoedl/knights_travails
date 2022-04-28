class Game
  MOVES = [[-1, -2], [1, 2], [-1, 2], [1, -2], [-2, -1], [2, 1], [-2, 1], [2, -1]]

  def initialize(player = nil)
    @player = player
  end

  def knight_moves(root, destination_space)
    parent = build_tree(root, destination_space)
    path = build_history(root, destination_space, parent)
    print_path(path.reverse)
  end

  def build_tree(root, destination_space, visited_squares = [root], queue = [], parent = {})
    unless root == destination_space
      MOVES.each_with_index do |move|
        next_potential_move = [root[0] + move[0], root[1] + move[1]]
        if try_move?(next_potential_move, visited_squares, queue)
          queue << next_potential_move
          parent[next_potential_move] = root
          visited_squares << next_potential_move
        end
      end
      next_move = queue.shift 
      build_tree(next_move, destination_space, visited_squares, queue, parent)
    end
    parent
  end

  def build_history(start, destination_space, parent)
    space = destination_space
    path = [space]
    until parent[space] == start
      space = parent[space]
      path << space
    end
    path << parent[space]
    path
  end

  def valid_move?(next_move)
    next_move[0].between?(-3, 4) && next_move[1].between?(-3, 4)
  end

  def try_move?(next_move, visited_squares, queue)
    valid_move?(next_move) && visited_squares.none?(next_move) && queue.none?(next_move)
  end

  def print_path(path)
    p "You made it in #{path.size - 1} moves! Here's your path:"
    path.each { |step| p step}
  end
end

board = Game.new("knight")
board.knight_moves([0, 0], [1, 2])
puts "\n"
board.knight_moves([0, 0], [-1, -2])
puts "\n"
board.knight_moves([0, 0], [3, 3])
puts "\n"
board.knight_moves([0, 0], [1, 4])
puts "\n"
board.knight_moves([3, 3], [0, 0])
puts "\n"
board.knight_moves([-3, -3], [4, 4])