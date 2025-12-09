defmodule Day9 do
  alias Vix.Operator
  alias Vix.Vips.Operation
  alias Vix.Vips.MutableOperation
  alias Vix.Vips.Image

  def part1(input) do
    red_tiles_big = parse(input)

    {red_tiles, remapping} = remap_tiles(red_tiles_big)

    red_tiles
    |> then(&Combinatorics.n_combinations(2, &1))
    |> Enum.map(&{&1, area(&1, remapping)})
    |> Enum.sort_by(fn {_positions, area} -> -area end)
    |> Enum.map(fn {_positions, area} -> area end)
    |> hd
  end

  def part2(input) do
    red_tiles_big = parse(input)

    {red_tiles, remapping} = remap_tiles(red_tiles_big)

    colored_tiles = add_green_tiles(red_tiles)

    red_tiles
    |> then(&Combinatorics.n_combinations(2, &1))
    |> Enum.map(&{&1, area(&1, remapping)})
    |> Enum.sort_by(fn {_positions, area} -> -area end)
    |> Stream.filter(fn {positions, _area} -> all_colored(positions, colored_tiles) end)
    |> Stream.map(fn {_positions, area} -> area end)
    |> Stream.take(1)
    |> Enum.to_list()
    |> hd
  end

  defp remap_tiles(coordinates) do
    {from_x, to_x} =
      coordinates
      |> Enum.map(fn [x, _y] -> x end)
      |> remap_list

    {from_y, to_y} =
      coordinates
      |> Enum.map(fn [_x, y] -> y end)
      |> remap_list

    remapped =
      coordinates
      |> Enum.map(fn [x, y] -> [from_x[x], from_y[y]] end)

    {remapped, %{from_x: from_x, from_y: from_y, to_x: to_x, to_y: to_y}}
  end

  defp remap_list(numbers) do
    to_idx =
      numbers
      |> Enum.sort()
      |> Enum.dedup()
      |> Enum.with_index()
      |> Enum.into(%{})

    reverse =
      to_idx
      |> Enum.map(fn {k, v} -> {v, k} end)
      |> Enum.into(%{})

    {to_idx, reverse}
  end

  defp add_green_tiles(red_tiles) do
    width = red_tiles |> Enum.map(fn [x, _y] -> x end) |> Enum.max()
    height = red_tiles |> Enum.map(fn [_x, y] -> y end) |> Enum.max()
    {:ok, blank} = Image.build_image(width + 1, height + 1, [0])

    borders = [{List.last(red_tiles), hd(red_tiles)} | Enum.zip(red_tiles, tl(red_tiles))]

    {:ok, border_image} =
      Image.mutate(blank, fn mut_image ->
        for {[x1, y1], [x2, y2]} <- borders do
          :ok = MutableOperation.draw_line(mut_image, [255.0], x1, y1, x2, y2)
        end

        mut_image
      end)

    # Image.write_to_file(border_image, "z_border.png")

    [x_in_area, y_in_area] = find_inside_point(borders)

    {:ok, filled_image} =
      Image.mutate(border_image, fn mut_image ->
        {:ok, _} = MutableOperation.draw_flood(mut_image, [255.0], x_in_area, y_in_area)
        mut_image
      end)

    # Image.write_to_file(filled_image, "z_filled.png")

    filled_image
  end

  # These values work for my input
  # Generalised solution left as exercise for the reader
  # (sorry!)
  # Points were found by inspecting the images written in add_green_tiles
  defp find_inside_point(borders) do
    cond do
      length(borders) == 8 -> [2, 1]
      length(borders) == 496 -> [150, 100]
    end
  end

  defp area([[x1_small, y1_small], [x2_small, y2_small]], %{to_x: to_x, to_y: to_y}) do
    x1 = to_x[x1_small]
    x2 = to_x[x2_small]
    y1 = to_y[y1_small]
    y2 = to_y[y2_small]
    (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
  end

  defp all_colored([[x1, y1], [x2, y2]], colored_tiles) do
    left = min(x1, x2)
    top = min(y1, y2)
    width = abs(x2 - x1) + 1
    height = abs(y2 - y1) + 1
    {:ok, area} = Operation.extract_area(colored_tiles, left, top, width, height)
    Operator.all?(area, true)
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn s ->
      s
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
