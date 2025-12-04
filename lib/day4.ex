defmodule Day4 do
  def part1(input) do
    {grid, size} = to_grid(input)

    grid
    |> Map.filter(fn {_, v} -> v == "@" end)
    |> Map.keys()
    |> Enum.map(fn k -> {k, count_roll_neighbours(grid, size, k)} end)
    |> Enum.filter(fn {_, v} -> v < 4 end)
    |> Enum.count()
  end

  def part2(_input) do
    :todo
  end

  defp to_grid(input) do
    lines = String.split(input, "\n")
    size = length(lines)

    grid =
      for {line, y} <- Enum.with_index(lines),
          {elem, x} <- Enum.with_index(String.graphemes(line)),
          into: %{} do
        {{x, y}, elem}
      end

    {grid, size}
  end

  defp neighbours({x, y}, size) do
    candidates =
      for dx <- -1..1, dy <- -1..1 do
        {x + dx, y + dy}
      end

    candidates
    |> Enum.reject(fn {cx, cy} -> cx == x && cy == y end)
    |> Enum.reject(fn {cx, cy} -> cx < 0 || cy < 0 end)
    |> Enum.reject(fn {cx, cy} -> cx >= size || cy >= size end)
  end

  defp count_roll_neighbours(grid, size, pos) do
    neighbours(pos, size)
    |> Enum.filter(fn n -> grid[n] == "@" end)
    |> Enum.count()
  end
end
