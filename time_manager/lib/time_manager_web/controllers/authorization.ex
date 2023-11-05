defmodule TimeManagerWeb.Authorization do

    def verify_user_id(conn, user_id) do
      header = Enum.find(conn.req_headers, fn {k, _} -> k == "authorization" end)
      case header do
        {"authorization", "Bearer " <> token} ->
        case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", token, max_age: 86400) do
          {:ok, token_data} ->
            if token_data.id == user_id do
              true
            else
              false
            end
          {:error, _} -> false
        end
      _ ->
        false
      end
  end

  def verify_role_manager(conn, manager) do
    header = Enum.find(conn.req_headers, fn {k, _} -> k == "authorization" end)
    case header do
      {"authorization", "Bearer " <> token} ->
        case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", token, max_age: 86400) do
          {:ok, token_data} ->
            if token_data.role == manager do
              true
            else
              false
            end
          {:error, _} -> false
        end
      _ ->
        false
    end
  end

  def verify_role_super_manager(conn, super_manager) do
    header = Enum.find(conn.req_headers, fn {k, _} -> k == "authorization" end)
    case header do
      {"authorization", "Bearer " <> token} ->
        case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", token, max_age: 86400) do
          {:ok, token_data} ->
            if token_data.role == super_manager do
              true
            else
              false
            end
          {:error, _} -> false
        end
      _ ->
        false
    end
  end
end
