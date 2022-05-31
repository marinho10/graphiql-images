defmodule GraphiQLImagesWeb.Telemetry do
  @moduledoc """
  The [:telemetry] library allows you to emit events
  at various stages of an application's lifecycle.
  You can then respond to these events by, among other
  things, aggregating them as metrics and sending the
  metrics data to a reporting destination.

  Telemetry stores events by their name in an ETS table,
  along with the handler for each event. Then, when a
  given event is executed, Telemetry looks up its handler
  and invokes it.

  More info (here)["https://hexdocs.pm/phoenix/telemetry.html"].
  """
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      # Telemetry poller will execute the given period measurements
      # every 10_000ms. Learn more here: https://hexdocs.pm/telemetry_metrics
      {:telemetry_poller, measurements: periodic_measurements(), period: 10_000}
      # Add reporters as children of your supervision tree.
      # {Telemetry.Metrics.ConsoleReporter, metrics: metrics()}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def metrics do
    [
      # Phoenix Metrics
      summary("phoenix.endpoint.stop.duration",
        unit: {:native, :millisecond}
      ),
      summary("phoenix.router_dispatch.stop.duration",
        tags: [:route],
        unit: {:native, :millisecond}
      ),

      # Database Time Metrics
      summary("graphiql_images_web.repo.query.total_time", unit: {:native, :millisecond}),
      summary("graphiql_images_web.repo.query.decode_time", unit: {:native, :millisecond}),
      summary("graphiql_images_web.repo.query.query_time", unit: {:native, :millisecond}),
      summary("graphiql_images_web.repo.query.queue_time", unit: {:native, :millisecond}),
      summary("graphiql_images_web.repo.query.idle_time", unit: {:native, :millisecond}),

      # VM Metrics
      summary("vm.memory.total", unit: {:byte, :kilobyte}),
      summary("vm.total_run_queue_lengths.total"),
      summary("vm.total_run_queue_lengths.cpu"),
      summary("vm.total_run_queue_lengths.io")
    ]
  end

  defp periodic_measurements do
    []
  end
end
