defmodule TestWorker do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    IO.puts("Init TestWorker with: #{inspect(args)}")
    {:ok, args}
  end
end
