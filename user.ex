defmodule Test.User do

  @derive {Inspect, only: [:name]}

  defstruct name: "no name yet", roles: []

end
