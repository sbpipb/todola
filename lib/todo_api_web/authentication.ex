defmodule TodoApiWeb.Authentication do
    use Authenticator, fallback: TodoApiWeb.FallbackController

    alias TodoApi.Repo
    alias TodoApi.Accounts.User

    def tokenize(user) do
        {:ok, to_string(user.id)}
    end

    def authenticate(user_id) do

        case Repo.get(User, user_id) do
            nil ->
                {:error, :unauthenticated}

            user ->
                {:ok, user}
        end 
    end
end