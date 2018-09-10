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
end
