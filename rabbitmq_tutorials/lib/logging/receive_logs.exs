defmodule LogReceiver do

  def wait_for_messages(channel) do
    receive do
      {:basic_deliver, payload, meta} ->
        IO.puts "[x] Received: #{payload}"
        payload
        |> to_char_list
        |> Enum.count(fn x -> x == ?. end)
        |> Kernel.*(1000)
        |> :timer.sleep

        IO.puts "[o] Completed. "
        AMQP.Basic.ack(channel, meta.delivery_tag)

        wait_for_messages(channel)
    end
  end

end

{:ok, connection} = AMQP.Connection.open
{:ok, channel} = AMQP.Channel.open(connection)
AMQP.Exchange.declare(channel, "logs", :fanout)
{:ok, %{queue: queue_name}} = AMQP.Queue.declare(channel, "", exclusive: true)

AMQP.Queue.bind(channel, queue_name, "logs")
AMQP.Basic.consume(channel, queue_name, nil, no_ack: true)
IO.puts """
  [*] Waiting for messages. To exit press CTRL+C, CTRL+C
"""
LogReceiver.wait_for_messages(channel)

