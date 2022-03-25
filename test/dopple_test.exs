defmodule DoppleTest do
  use ExUnit.Case
  doctest Dopple

  test "greets the world" do
    assert Dopple.hello() == :world
  end
end
