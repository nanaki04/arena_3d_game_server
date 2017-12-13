defmodule Arena.Portal do
  @moduledoc """

  ## Examples

      iex> login_charm = %Arena.Charm.Login{name: "Enda", password: "win"}
      ...> Arena.Portal.follow :duelist, :login, [login_charm]
      %{"Enda" => [%Arena.Charm.LoginOk{type: :login_ok, name: "Enda"}]}
      ...> Arena.Portal.follow :duelist, :login, [Map.put(login_charm, :password, "fail")]
      %{"Enda" => [%Arena.Charm.LoginFailed{type: :login_failed}]}

      iex> participate_charm = %Arena.Charm.Participate{agora: "global", participant: "Enda"}
      ...> Arena.Portal.follow :agora, :participate, [participate_charm]
      %{"Enda" => [%Arena.Charm.Participate{agora: "global", participant: "Enda"}]}
      ...> speak_charm = %Arena.Charm.Speak{agora: "global", participant: "Enda", words: "hi!"}
      ...> Arena.Portal.follow :agora, :speak, [speak_charm]
      %{"Enda" => [%Arena.Charm.Speak{agora: "global", participant: "Enda", words: "hi!"}, %Arena.Charm.Participate{agora: "global", participant: "Enda"}]}

  """
  use PathFinder

  gatekeeper Arena.Portal.Corridor

  footprints Arena.Portal.Duelist
  footprints Arena.Portal.Agora

end
