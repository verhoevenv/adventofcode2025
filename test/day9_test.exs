defmodule Day9Test do
  use ExUnit.Case

  def example_input do
    """
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
    """
    |> String.trim_trailing("\n")
  end

  test "part1" do
    assert Day9.part1(example_input()) == 50
  end

  test "part2" do
    assert Day9.part2(example_input()) == 24
  end
end
