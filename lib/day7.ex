defmodule Day7 do
  def part1(input) do
    grid = to_grid(input)
    start = find_start(grid)

    %{size_y: max_level} = grid

    {beams_hit, _final_beams} =
      0..max_level
      |> Enum.reduce({0, [start]}, fn _level, acc -> follow_beam(grid, acc) end)

    beams_hit
  end

  def part2(_input) do
    "todo"
  end

  defp follow_beam(grid, {old_splits, beams}) do
    %{cells: cells} = grid
    next_level_beams = beams |> Enum.map(fn {x, y} -> {x, y + 1} end)

    splitters_hit =
      next_level_beams
      |> Enum.filter(&(cells[&1] == :split))

    split_beams =
      splitters_hit
      |> Enum.flat_map(fn {x, y} -> [{x - 1, y}, {x + 1, y}] end)
      |> Enum.sort_by(fn {x, _y} -> x end)
      |> Enum.dedup()

    final_beams =
      (next_level_beams ++ split_beams)
      |> Enum.reject(fn pos -> Enum.member?(splitters_hit, pos) end)
      |> Enum.sort_by(fn {x, _y} -> x end)
      |> Enum.dedup()

    num_splits = length(splitters_hit)
    {num_splits + old_splits, final_beams}
  end

  defp to_grid(input) do
    lines = String.split(input, "\n")
    size_y = length(lines)
    size_x = String.length(List.first(lines))

    cells =
      for {line, y} <- Enum.with_index(lines),
          {elem, x} <- Enum.with_index(String.graphemes(line)),
          into: %{} do
        {{x, y}, parse_elem(elem)}
      end

    %{cells: cells, size_x: size_x, size_y: size_y}
  end

  defp parse_elem(input) do
    case input do
      "." -> :empty
      "S" -> :start
      "^" -> :split
    end
  end

  defp find_start(grid) do
    %{cells: cells} = grid

    cells
    |> Enum.find(fn {_pos, elem} -> elem == :start end)
    |> then(fn {pos, _elem} -> pos end)
  end
end
