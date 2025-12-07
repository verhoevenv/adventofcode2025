defmodule Day7 do
  def part1(input) do
    grid = to_grid(input)
    start = find_start(grid)

    %{size_y: max_level} = grid

    {beams_hit, _final_beams} =
      0..max_level
      |> Enum.reduce({0, [start]}, fn _level, acc -> follow_recombined_beam(grid, acc) end)

    beams_hit
  end

  def part2(input) do
    grid = to_grid(input)
    start = find_start(grid)

    %{cells: cells, size_y: max_level} = grid

    {result, _memo} = follow_quantum_beam(start, cells, max_level, %{})
    result
  end

  defp follow_recombined_beam(grid, {old_splits, beams}) do
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

  defp follow_quantum_beam({_beam_x, beam_y}, _cells, max_level, memo)
       when beam_y == max_level do
    {1, memo}
  end

  defp follow_quantum_beam(beam_position, cells, max_level, memo) do
    if Map.has_key?(memo, beam_position) do
      {memo[beam_position], memo}
    else
      {old_x, old_y} = beam_position
      next_position = {old_x, old_y + 1}

      if cells[next_position] == :split do
        beam_left = {old_x - 1, old_y + 1}
        beam_right = {old_x + 1, old_y + 1}

        {result_left, memo_left} = follow_quantum_beam(beam_left, cells, max_level, memo)
        {result_right, memo_right} = follow_quantum_beam(beam_right, cells, max_level, memo_left)
        result = result_left + result_right
        new_memo = Map.put(memo_right, beam_position, result)
        {result, new_memo}
      else
        {result, memo_next} = follow_quantum_beam({old_x, old_y + 1}, cells, max_level, memo)
        new_memo = Map.put(memo_next, beam_position, result)
        {result, new_memo}
      end
    end
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
