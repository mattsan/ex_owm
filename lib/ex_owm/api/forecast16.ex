defmodule ExOwm.Api.Forecast16 do
  defstruct [:city]

  alias ExOwm.Api.Forecast16

  def new do
    %Forecast16{}
  end
end
