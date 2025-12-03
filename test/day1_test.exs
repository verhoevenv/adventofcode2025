defmodule Day1Test do
  use ExUnit.Case

  def example_input do
    """
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """
    |> String.trim_trailing("\n")
  end

  def single_rotate_input do
    """
    L50
    """
    |> String.trim_trailing("\n")
  end

  test "part1" do
    assert Day1.part1(example_input()) == 3
  end

  test "part2" do
    assert Day1.part2(example_input()) == 6
    assert Day1.part2(single_rotate_input()) == 1
  end
end
