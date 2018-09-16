defmodule ExOwm do
  @server ExOwm.Api

  def current, do: GenServer.call(@server, :current)
  def forecast5, do: GenServer.call(@server, :forecast5)
  def forecast16, do: GenServer.call(@server, :forecast16)
  def get_params, do: GenServer.call(@server, :get_params)
  def set_params(params), do: GenServer.call(@server, {:set_params, params})
end
