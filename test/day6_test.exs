defmodule Day6Test do
  use ExUnit.Case

  def example_input do
    # formatter destroys spaces at end of multiline string,
    # we have to be a bit more careful here :)
    [
      "123 328  51 64 ",
      " 45 64  387 23 ",
      "  6 98  215 314",
      "*   +   *   +  "
    ]
    |> Enum.join("\n")
  end

  test "part1" do
    assert Day6.part1(example_input()) == 4_277_556
  end

  test "part2" do
    assert Day6.part2(example_input()) == 3_263_827
  end
end
