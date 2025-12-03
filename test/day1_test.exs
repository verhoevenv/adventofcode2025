defmodule Day1Test do
  use ExUnit.Case

  test "part1" do
    input =
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

    assert Day1.part1(input) == 3
  end
end
