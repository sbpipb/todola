defmodule TodoApiWeb.ListController do
  use TodoApiWeb, :controller

  def create(conn, %{ "list" => list_params } ) do

    case TodoApi.Lists.create_list(list_params) do
      {:ok, list} ->
        conn |> json(%{ message: "List created", title: list.title, id: list.id, description: list.description})

      {:error, changeset } ->
        raise changeset.errors
        conn |> json(%{ message: "sablay talaga", changeset: changeset})

      _ ->
        raise "else lang"
        conn |> json(%{ message: "failed to register "})

    end
  end
end
