defmodule TodoApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoApi.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        username: "some username"
      })
      |> TodoApi.Accounts.create_user()

    user
  end
end
