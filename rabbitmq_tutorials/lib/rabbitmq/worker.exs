defmodule Worker do

  def wait_for_messages(channel, c) do
    receive do
      {:basic_deliver, payload, meta} ->
        IO.puts "[#{c}] Received: #{payload}"
        payload
        |> to_char_list
        |> Enum.count(fn x -> x == ?. end)
        |> Kernel.*(1000)
        |> :timer.sleep

        IO.puts "[!] Completed. "
        AMQP.Basic.ack(channel, meta.delivery_tag)

        wait_for_messages(channel, c + 1)
    end
  end

end

queue_name  = "task_queue"
prefetch_count = 1
{:ok, connection} = AMQP.Connection.open
{:ok, channel} = AMQP.Channel.open(connection)
AMQP.Queue.declare(channel, queue_name, durable: true)
AMQP.Basic.qos(channel, prefetch_count: prefetch_count)
AMQP.Basic.consume(channel, queue_name)
IO.puts """
  [*] Waiting for messages. To exit press CTRL+C, CTRL+C
"""
Worker.wait_for_messages(channel, 0)

