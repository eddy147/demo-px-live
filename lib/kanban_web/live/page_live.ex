defmodule KanbanWeb.PageLive do
  use Phoenix.LiveView

  def mount(_params, %{"board_id" => board_id}, socket) do
    with {:ok, board} <- Kanban.Board.find(board_id) do
      {:ok, assign(socket, :board, board)}
    else
      {:error, _reason} -> {:ok, redirect(socket, to: "/error")}
    end
  end
end
