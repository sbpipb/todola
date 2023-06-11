defmodule TodoApiWeb.PageController do
  use TodoApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", fruits: ["banana", "durian"])
  end
end
