defmodule KanbanWeb.PageLive do
  use Phoenix.LiveView

  def mount(_params, %{"board_id" => board_id}, socket) do
    with {:ok, board} <- Kanban.Board.find(board_id) do
      {:ok, assign(socket, :board, board)}
    else
      {:error, _reason} -> {:ok, redirect(socket, to: "/error")}
    end
  end

  def handle_event("add_card", %{"column" => column_id}, socket) do
    IO.inspect("column id = #{column_id}")
    {id, _} = Integer.parse(column_id)
    %Kanban.Card{column_id: id, content: "Something new"} |> Kanban.Repo.insert!()
    case Kanban.Board.find(socket.assigns.board.id) do
      {:ok, new_board} -> {:noreply, assign(socket, :board, new_board)}
      _ -> {:noreply, socket}
    end
  end
end
