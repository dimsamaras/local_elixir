queue_name = "task_queue"
{:ok, connection} = AMQP.Connection.open
{:ok, channel} = AMQP.Channel.open(connection)

AMQP.Queue.declare(channel, queue_name, durable: true)

message =
  case System.argv do
    [] -> "Hello World!"
    words -> Enum.join(words, " ")
  end

AMQP.Basic.publish(channel, "", queue_name, message, durable: true)

IO.puts " [x] Sent #{message}"

AMQP.Connection.close(connection)
