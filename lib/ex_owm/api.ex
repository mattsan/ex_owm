defmodule ExOwm.Api do
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

  def current(%Query{} = query), do: request(@current_url, query, ExOwm.Api.Current.new())
  def forecast5(%Query{} = query), do: request(@forecast5_url, query, ExOwm.Api.Forecast5.new())
  def forecast16(%Query{} = query), do: request(@forecast16_url, query, ExOwm.Api.Forecast16.new())

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
