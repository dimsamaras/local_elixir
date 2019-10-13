defmodule RelationshipTest do
  use ExUnit.Case

  test "create new players" do
    the_woman = Woman.new("Efi")
    assert %Woman{name: "Efi"} = the_woman
    the_man   = Man.new("Sam")
    assert %Man{name: "Sam"} = the_man
  end

  test "create new relationship" do
    {:ok, relationship} = Relationship.start_new()
    assert :new = Relationship.get_status(relationship)
  end
end
