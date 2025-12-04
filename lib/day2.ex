defmodule Day2 do
  def part1(input) do
    input
    |> String.split(",")
    |> Enum.map(fn line -> String.split(line, "-") |> Enum.map(&String.to_integer/1) end)
    |> Enum.flat_map(&find_invalid_ids_part1/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split(",")
    |> Enum.map(fn line -> String.split(line, "-") |> Enum.map(&String.to_integer/1) end)
    |> Enum.flat_map(&find_invalid_ids_part2/1)
    |> Enum.sum()
  end

  defp find_invalid_ids_part1([from, to]) do
    from..to
    |> Stream.map(&Integer.to_charlist/1)
    |> Stream.filter(&is_repeated_sequence?/1)
    |> Stream.map(&List.to_integer/1)
  end

  defp find_invalid_ids_part2([from, to]) do
    from..to
    |> Stream.map(&Integer.to_charlist/1)
    |> Stream.filter(fn list ->
      max_chunk = max(div(length(list), 2), 1)

      1..max_chunk
      |> Enum.any?(&has_repetion_of_length?(list, &1))
    end)
    |> Stream.map(&List.to_integer/1)
  end

  defp is_repeated_sequence?(list)
       when rem(length(list), 2) != 0, do: false

  defp is_repeated_sequence?(list) do
    half_length = div(length(list), 2)
    has_repetion_of_length?(list, half_length)
  end

  defp has_repetion_of_length?(list, length)
       when rem(length(list), length) != 0, do: false

  defp has_repetion_of_length?(list, length)
       when rem(length(list), length) == 0 do
    list
    |> Enum.chunk_every(length)
    |> all_same_elements?
  end

  defp all_same_elements?(list) do
    [head | tail] = list
    same_elements = tail |> Enum.all?(&(&1 === head))
    length(list) > 1 && same_elements
  end
end
