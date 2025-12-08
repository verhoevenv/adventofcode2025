defmodule Day8 do
  def part1(input, num_connections \\ 1000) do
    boxes = parse(input)

    initial_circuits = boxes |> Enum.map(fn box -> MapSet.new([box]) end)

    ordered_connections =
      boxes
      |> then(&Combinatorics.n_combinations(2, &1))
      |> Enum.map(&{&1, distance(&1)})
      |> Enum.sort_by(fn {_positions, dist} -> dist end)
      |> Enum.map(fn {positions, _dist} -> positions end)

    ordered_connections
    |> Enum.take(num_connections)
    |> Enum.reduce(initial_circuits, &group_circuits/2)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort_by(fn l -> -l end)
    |> Enum.take(3)
    |> Enum.product()
  end

  def part2(input) do
    boxes = parse(input)

    initial_circuits = boxes |> Enum.map(fn box -> MapSet.new([box]) end)

    ordered_connections =
      boxes
      |> then(&Combinatorics.n_combinations(2, &1))
      |> Enum.map(&{&1, distance(&1)})
      |> Enum.sort_by(fn {_positions, dist} -> dist end)
      |> Enum.map(fn {positions, _dist} -> positions end)

    ordered_connections
    |> Enum.reduce_while(initial_circuits, fn connection, circuits ->
      new_circuits = group_circuits(connection, circuits)

      if length(new_circuits) > 1 do
        {:cont, new_circuits}
      else
        {:halt, connection}
      end
    end)
    |> then(fn [[x1, _, _], [x2, _, _]] -> x1 * x2 end)
  end

  defp distance([[x1, y1, z1], [x2, y2, z2]]) do
    ((x2 - x1) ** 2 + (y2 - y1) ** 2 + (z2 - z1) ** 2) ** 0.5
  end

  defp group_circuits([from, to], circuits) do
    circuit_with_from =
      circuits
      |> Enum.find(fn c -> c |> MapSet.member?(from) end)

    circuit_with_to =
      circuits
      |> Enum.find(fn c -> c |> MapSet.member?(to) end)

    joined_circuit = MapSet.union(circuit_with_from, circuit_with_to)

    new_circuits =
      circuits
      |> List.delete(circuit_with_from)
      |> List.delete(circuit_with_to)
      |> then(&[joined_circuit | &1])

    new_circuits
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
