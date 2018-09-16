defmodule ExOwm.Api do
  use GenServer

  alias ExOwm.Api.Query

  @owm_version "2.5"

  @owm_uri %URI{
    authority: "api.openweathermap.org",
    host: "api.openweathermap.org",
    port: 80,
    scheme: "http",
  }

  @current_url %{@owm_uri | path: "/data/#{@owm_version}/weather"}
  @forecast5_url %{@owm_uri | path: "/data/#{@owm_version}/forecast"}
  @forecast16_url %{@owm_uri | path: "/data/#{@owm_version}/forecast/daily"}

  @module __MODULE__

  def start_link(opts) do
    GenServer.start_link(@module, opts, name: @module)
  end

  def init(opts) do
    query = Query.init(opts)
    {:ok, %{query: query}}
  end

  def handle_call(:current, _from, state) do
    result = request(@current_url, state.query, ExOwm.Api.Current.new())
    {:reply, result, state}
  end

  def handle_call(:forecast5, _from, state) do
    result =
      case request(@forecast5_url, state.query, ExOwm.Api.Forecast5.new()) do
        {:ok, 200, forecast5} ->
          {:ok, 200, update_in(forecast5, [:list, Access.all(), :dt], & &1 |> Timex.from_unix() |> Timex.local())}

        result ->
          result
      end

    {:reply, result, state}
  end

  def handle_call(:forecast16, _from, state) do
    result = request(@forecast16_url, state.query, ExOwm.Api.Forecast16.new())
    {:reply, result, state}
  end

  def handle_call(:get_params, _from, state) do
    {:reply, state.query, state}
  end

  def handle_call({:set_params, params}, _from, state) do
    query =
      params
      |> Enum.reduce(state.query, fn {key, value}, acc ->
        %{acc | key => value}
      end)

    {:reply, query, %{state | query: query}}
  end

  defp request(%URI{} = uri, %Query{} = query, weather) do
    response =
      %{uri | query: Query.encode(query)}
      |> HTTPoison.get()

    case response do
      {:ok, %HTTPoison.Response{status_code: 200} = resp} ->
        {:ok, json} = Poison.decode(resp.body, as: weather)
        {:ok, 200, json}

      {:ok, %HTTPoison.Response{status_code: statu_code} = resp} ->
        {:ok, json} = Poison.decode(resp.body)
        {:ok, statu_code, json}

      resp ->
        resp
    end
  end
end
