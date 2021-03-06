class Robot
  class CommandIgnoredError < StandardError; end

  attr_reader :position, :direction

  def place(position, direction)
    @position = position
    @direction = direction
  end

  def move_forward
    raise CommandIgnoredError if ignore_commands?
    new_position = @position + @direction
    @position = new_position if can_move_to?(new_position)
  end

  def turn_left
    raise CommandIgnoredError if ignore_commands?
    @direction = @direction.rotate_counter_clockwise
  end

  def turn_right
    raise CommandIgnoredError if ignore_commands?
    @direction = @direction.rotate_clockwise
  end

  def report
    raise CommandIgnoredError if ignore_commands?
    "#{@position},#{@direction}"
  end

private

  def can_move_to?(position)
    position.on_board?
  end

  def ignore_commands?
    !placed? || !on_board?
  end

  def placed?
    @position && @direction
  end

  def on_board?
    @position.on_board?
  end
end
