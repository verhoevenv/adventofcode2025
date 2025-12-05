defmodule Day5Test do
  use ExUnit.Case

  def example_input do
    """
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """
    |> String.trim_trailing("\n")
  end

  test "part1" do
    assert Day5.part1(example_input()) == 3
  end

  test "part2" do
    assert Day5.part2(example_input()) == "done"
  end
end
