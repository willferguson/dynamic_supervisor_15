defmodule TestSupervisor do
    use Supervisor

    def start_link({m,f,a}) do
      Supervisor.start_link(__MODULE__, {m,f,a}, name: :test_supervisor)
    end

    def init({module, function, args}) do
      child_spec = Supervisor.child_spec(
                              module,
                              start: {module, function, args},
                              restart: :temporary)

      spec = Supervisor.init([child_spec], strategy: :simple_one_for_one)
      IO.puts("Initialialising TestSupervisor with: #{inspect(spec)}")
      spec
    end

    def start_worker(args) when is_list(args) do
      Supervisor.start_child(:test_supervisor, args)
    end

    def start_worker(_args) do
      {:error, "Args must be a list"}
    end
end
