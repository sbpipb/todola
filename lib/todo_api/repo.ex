defmodule TodoApi.Repo do
  use Ecto.Repo,
    otp_app: :todo_api,
    adapter: Ecto.Adapters.SQLite3
end
