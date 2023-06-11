defmodule TodoApiWeb.SessionJSON do
  # alias TodoApiWeb.Authentication.Session

  def index() do
    [%{ data: [], message: "login authentication" }]
  end
end
