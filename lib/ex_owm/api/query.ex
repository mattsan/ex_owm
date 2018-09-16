defmodule ExOwm.Api.Query do
  defstruct [
    :api_key,
    :city_name,
    :city_id,
    :zip_code,
    :latitude,
    :longitude,
    :units,
    :language
  ]

  @key_pairs [
    appid: :api_key,
    q: :city_name,
    id: :city_id,
    zip: :zip_code,
    lat: :latitude,
    lon: :longitude,
    units: :units,
    lang: :language
  ]

  alias ExOwm.Api.Query

  def init(opts) do
    %Query{
      api_key: get_param(opts, :api_key),
      city_name: get_param(opts, :city_name),
      city_id: get_param(opts, :city_id),
      zip_code: get_param(opts, :zip_code),
      latitude: get_param(opts, :latitude),
      longitude: get_param(opts, :longitude),
      units: get_param(opts, :units),
      language: get_param(opts, :language)
    }
  end

  def encode(%Query{} = query) do
    @key_pairs
    |> Enum.reduce([], fn {uri_key, st_key}, acc ->
      case Map.get(query, st_key) do
        nil -> acc
        value -> [{uri_key, value} | acc]
      end
    end)
    |> URI.encode_query()
  end

  defp get_param(options, key) do
    get_in(options, [key]) || Application.get_env(:ex_owm, key)
  end
end
