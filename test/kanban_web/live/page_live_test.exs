defmodule KanbanWeb.PageLiveTest do
  use KanbanWeb.ConnCase

  import Phoenix.LiveViewTest

  test "connected render displays board title and column", %{conn: conn} do
    %{id: id} = create_board()
    %{id: _column_id} = create_column(id)

    {:ok, page_live, _disconnected_html} = live(conn, "/boards/#{id}")
    assert render(page_live) =~ "<h1>A test project</h1>"
    assert render(page_live) =~ "<h3 class=\"panel-title\">A test column</h3>"
  end

  test "wrong board URL redirects to error", %{conn: conn} do
    assert {:error, {:redirect, %{to: "/error"}}} = live(conn, "/boards/123")
  end

  defp create_board() do
    %Kanban.Board{title: "A test project"}
    |> Kanban.Repo.insert!()
  end

  defp create_column(board_id) do
    %Kanban.Column{title: "A test column", board_id: board_id}
    |> Kanban.Repo.insert!()
  end
end
