defmodule Day4Test do
  use ExUnit.Case

  def example_input do
    """
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
    """
    |> String.trim_trailing("\n")
  end

  test "part1" do
    assert Day4.part1(example_input()) == 13
  end

  test "part2" do
    assert Day4.part2(example_input()) == 43
  end
end
