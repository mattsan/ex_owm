defmodule ExOwm.Api.Forecast5 do
  defstruct [:city]

  alias ExOwm.Api.Forecast5

  def new do
    %Forecast5{}
  end
end
