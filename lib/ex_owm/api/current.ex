defmodule ExOwm.Api.Current do
  defstruct [:coord, :weather, :base, :main, :wind, :clouds, :rain, :snow, :dt, :sys, :id, :name, :cod]

  defmodule Coord do
    defstruct [:lon, :lat]
  end

  defmodule Weather do
    defstruct [:id, :main, :description, :icon]
  end

  defmodule Main do
    defstruct [:temp, :pressure, :humidity, :temp_min, :temp_max, :sea_level, :grnd_level]
  end

  defmodule Wind do
    defstruct [:speed, :deg]
  end

  defmodule Clouds do
    defstruct [:all]
  end

  defmodule Volume do
    defstruct [:"3h"]
  end

  defmodule Sys do
    defstruct [:type, :id, :message, :country, :sunrise, :sunset]
  end

  alias ExOwm.Api.Current

  def new do
    %Current{
      coord: %Coord{},
      weather: [%Weather{}],
      main: %Main{},
      wind: %Wind{},
      clouds: %Clouds{},
      rain: %Volume{},
      snow: %Volume{},
      sys: %Sys{}
    }
  end
end
