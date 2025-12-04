defmodule Day3Test do
  use ExUnit.Case

  def example_input do
    """
    987654321111111
    811111111111119
    234234234234278
    818181911112111
    """
    |> String.trim_trailing("\n")
  end

  test "part1" do
    assert Day3.part1(example_input()) == 357
  end

  test "part2" do
    assert Day3.part2(example_input()) == 3_121_910_778_619
  end
end
