defmodule PhantomJS do
  def start do
    {:ok, pid} = GenServer.start_link(__MODULE__, [])
    Process.register(pid, :phantomjs)
    :timer.sleep(750)
  end

  def clear_local_storage do
    GenServer.call(:phantomjs, :clear_local_storage)
  end

  # GenServer

  def init(_) do
    local_storage = gen_local_storage()

    port =
      Port.open({:spawn, phantomjs_command(local_storage)}, [
        :binary,
        :stream,
        :use_stdio,
        :exit_status
      ])

    Process.flag(:trap_exit, true)
    {:ok, %{port: port, local_storage: local_storage}}
  end

  def handle_call(:clear_local_storage, _from, state) do
    result = File.rm_rf(state.local_storage)

    {:reply, result, state}
  end

  def handle_info(_, state), do: {:noreply, state}

  def terminate(_reason, state) do
    Port.close(state.port)
    File.rm_rf(state.local_storage)
  end

  defp phantomjs_command(local_storage) do
    "bin/run.sh phantomjs -w --local-storage-path=#{local_storage}"
  end

  defp gen_local_storage do
    dirname =
      :rand.uniform(0x100000000)
      |> Integer.to_string(36)
      |> String.downcase()

    local_storage = Path.join(System.tmp_dir!(), dirname)
    File.mkdir_p(local_storage)

    local_storage
  end
end
