defmodule ExOwm.Api.Forecast16 do
  defstruct [:city, :cod, :message, :cnt, :list]

  defmodule List do
    defstruct [:dt, :temp, :pressure, :humidity, :weather, :speed, :deg, :clouds]
  end

  alias ExOwm.Api.Forecast16
  alias ExOwm.Api.Response.{City, Coord, Weather, Temp}

  def new do
    %Forecast16{
      city: %City{
        coord: %Coord{}
      },
      list: %List{
        temp: %Temp{},
        weather: [%Weather{}]
      }
    }
  end
end
