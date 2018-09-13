defmodule ExOwm.Api.Response do
  defmodule Coord do
    defstruct [:lon, :lat]
  end

  defmodule City do
    defstruct [:id, :name, :coord, :country]
  end

  defmodule Main do
    defstruct [:temp, :pressure, :humidity, :temp_min, :temp_max, :sea_level, :grnd_level]
  end

  defmodule Weather do
    defstruct [:id, :main, :description, :icon]
  end

  defmodule Clouds do
    defstruct [:all]
  end

  defmodule Wind do
    defstruct [:speed, :deg]
  end

  defmodule Volume do
    defstruct [:"3h"]
  end

  defmodule Temp do
    defstruct [:day, :min, :max, :night, :eve, :morn]
  end

  defmodule Sys do
    defstruct [:type, :id, :message, :country, :sunrise, :sunset]
  end
end
