defmodule LinkedList do
  @opaque t :: tuple()
  @empty %{:value => nil, :next => nil}
  @empty_list {:error, :empty_list}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do:  node(nil, nil)

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: node(elem, list)

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    case list.next do
      nil -> 0
      _   -> 1 + LinkedList.length(list.next)
    end 
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(@empty), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(@empty), do: @empty_list
  def peek(list), do: {:ok, list.value}
  
  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(@empty), do: @empty_list
  # def tail(list) do
  #   case list.next do
  #     @empty -> {:ok, list.value}
  #     _      -> LinkedList.tail(list.next)    
  #   end  
  # end
  def tail(list), do: {:ok, list.next}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(@empty), do: @empty_list
  def pop(list), do: {:ok, list.value, list.next}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list 
    |> Enum.reverse
    |> Enum.reduce(LinkedList.new(), &LinkedList.push(&2, &1))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(@empty), do: []
  def to_list(list) do
    {:ok, value, next} = LinkedList.pop(list)
    [value | to_list(next)]
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list
    |> to_list
    |> Enum.reverse
    |> from_list
  end

  defp node(value, next), do: %{:value => value, :next => next}
end
