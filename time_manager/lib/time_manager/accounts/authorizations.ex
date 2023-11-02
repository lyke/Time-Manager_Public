defmodule TimeManager.Accounts.Authorization do
  import Canada, only: [can?: 2]

  def can_access_post?(user, post) do
    user |> can? :read, post
  end
end
