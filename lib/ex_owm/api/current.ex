defmodule ExOwm.Api.Current do
  defstruct [:coord, :weather, :base, :main, :wind, :clouds, :rain, :snow, :dt, :sys, :id, :name, :cod]

  alias ExOwm.Api.Current
  alias ExOwm.Api.Response.{Coord, Main, Weather, Wind, Clouds, Volume, Sys}

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
