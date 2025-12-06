defmodule Day6Test do
  use ExUnit.Case

  def example_input do
    """
    123 328  51 64
     45 64  387 23
      6 98  215 314
    *   +   *   +
    """
    |> String.trim_trailing("\n")
  end

  test "part1" do
    assert Day6.part1(example_input()) == 4277556
  end

  test "part2" do
    assert Day6.part2(example_input()) == "done"
  end
end
