defmodule TestSupervisorTest do
  use ExUnit.Case, async: true

  test "Can start a worker" do
    TestSupervisor.start_link({TestWorker, :start_link, []})
    assert {:ok, _pid} = TestSupervisor.start_worker(["1"])
    assert {:ok, _pid} = TestSupervisor.start_worker(["2"])
    assert {:ok, _pid} = TestSupervisor.start_worker(["3"])
    children = Supervisor.count_children(:test_supervisor)
    assert 3 = children.active
    assert 3 = children.workers
  end

  test "Cannot pass non-list args to supervisor" do
    TestSupervisor.start_link({TestWorker, :start_link, []})
    assert {:error, _} = TestSupervisor.start_worker("wrong")
  end


end
