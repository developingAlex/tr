
# X x Y grid, 

# 5 units by 5 units table. origin (0,0) is at lower left corner
WIDTH = 5
HEIGHT = 5

class Table
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end
end

class Robot

  def initialize (table)
    @table = table
    @x = nil
    @y = nil
    @facing = nil
    @not_placed_yet = true
  end

  # returns true if successfully placed, false if not, 
  # a placement will fail if the coords are 'off' the table
  def place (x, y, facing)
    directions = ['N','E','S','W']

    if valid_move?(x,y)
      @x = x
      @y = y
      @facing = directions.include?(facing.upcase) ? facing : 'N'
      @not_placed_yet = false
    end
    !@not_placed_yet
  end

  
  # updates the robots position one unit towards the direction it is facing
  # assuming the move would not result in the robot moving 'off' the table.
  def move
    if @x.nil? || @y.nil?
      return # do not move if not yet placed on table
    end


    # if facing north, increment y
    # if facing south decrement y
    # if facing east increment x
    # if facing west decrement x
    x_result = @x
    y_result = @y
    case @facing
    when 'N'
      y_result += 1    
    when 'S'
      y_result -= 1
    when 'E'
      x_result += 1
    when 'W'
      x_result -= 1
    end

    # if the move was valid then allow it
    if valid_move?(x_result, y_result)
      @x = x_result
      @y = y_result
    end

  end
  
  # report the status of the robot in the form (x position, y position, direction currently facing)
  def report
    if @x.nil?
      "I'm ready to be placed on the table"
    else
      "(#{@x},#{@y},#{@facing})"
    end
  end
  
  def turn (direction)
    if @facing.nil?
      return # do not turn if not even placed on table
    end
    directions = ['N','E','S','W']
    
    # if the direction is right, that's clockwise increment and overflow the direction array
    # if the direction is left, that's anti clockwise, decrement and underflow the direction array to get the next value.
    if direction == 'right'

      now_facing = directions[(directions.find_index(@facing) + 1) % 4 ] # mod 4 to handle overflows
    else
      now_facing = directions[directions.find_index(@facing) - 1 ] # no need to handle overflow here because ruby understands -1 as being the last index which is what we want

    end
    @facing = now_facing
  end
  
  private 

  def valid_move? (x,y)
    if x < 0 || x > @table.width || y < 0 || y > @table.height
      false
    else
      true
    end
  end

end

test_table = Table.new(WIDTH, HEIGHT)
mr_robot = Robot.new(test_table)

mr_robot.place(0,0,'N')
puts mr_robot.report # expecting (0,0,'N')
mr_robot.move
mr_robot.turn('right')
mr_robot.move
puts mr_robot.report # expecting (1,1,'E')
mr_robot.move
mr_robot.move
mr_robot.move
mr_robot.move
mr_robot.move
mr_robot.move
mr_robot.turn('left')
mr_robot.move
mr_robot.move
mr_robot.move
mr_robot.move
mr_robot.move
mr_robot.turn('left')
mr_robot.move
mr_robot.move
mr_robot.move
mr_robot.move
mr_robot.move
puts mr_robot.report

