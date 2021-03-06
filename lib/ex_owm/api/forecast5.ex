defmodule ExOwm.Api.Forecast5 do
  @behaviour Access

  defstruct [:cod, :message, :city, :cnt, :list]

  defmodule List do
    @behaviour Access

    defstruct [:dt, :main, :weather, :clouds, :wind, :rain, :snow, :dt_txt]

    def fetch(%List{} = list, key) when key in [:dt, :main, :weather, :clouds, :wind, :rain, :snow, :dt_txt] do
      {:ok, Map.get(list, key)}
    end

    def fetch(%List{}, _), do: :error

    def get_and_update(%List{} = list, key, function) do
      value = Map.get(list, key)
      {get_value, update_value} = function.(value)
      {get_value, %{list | key => update_value}}
    end

    def pop(_data, _key), do: :erlang.error(RuntimeError.exception("has not been implemented"))
  end

  alias ExOwm.Api.Forecast5
  alias ExOwm.Api.Response.{City, Coord, Main, Weather, Clouds, Wind, Volume}

  def new do
    %Forecast5{
      city: %City{
        coord: %Coord{}
      },
      list: [
        %List{
          main: %Main{},
          weather: [%Weather{}],
          clouds: %Clouds{},
          wind: %Wind{},
          rain: %Volume{},
          snow: %Volume{}
        }
      ]
    }
  end

  def fetch(%Forecast5{} = forecast, key) when key in [:cod, :message, :city, :cnt, :list] do
    {:ok, Map.get(forecast, key)}
  end

  def fetch(%Forecast5{}, _), do: :error

  def get_and_update(%Forecast5{} = forecast5, key, function) do
    value = Map.get(forecast5, key)
    {get_value, update_value} = function.(value)
    {get_value, %{forecast5 | key => update_value}}
  end

  def pop(_data, _key), do: :erlang.error(RuntimeError.exception("has not been implemented"))
end
