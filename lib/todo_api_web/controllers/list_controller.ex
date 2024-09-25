defmodule TodoApiWeb.ListController do
  use TodoApiWeb, :controller

  def create(conn, %{"list" => list_params } ) do

    case TodoApi.Lists.create_list(list_params) do
      {:ok, list} ->
        conn |> json(%{message: "List created", title: list.title, id: list.id, description: list.description})

      {:error, changeset } ->
        error_list = changeset.errors
                      |> Enum.map(fn {attr, {msg, _constraints} = _v} ->
                        "#{attr} #{msg}"
                      end)

        conn |> json(%{message: "failed to create", errors: error_list})
    end
  end
end
