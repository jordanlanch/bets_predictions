defmodule ScrappingBetWeb.PageController do
  use ScrappingBetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
