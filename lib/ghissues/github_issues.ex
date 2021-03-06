defmodule Ghissues.GithubIssues do
  @user_agent [ { "User-agent", "Elixir eric.churchill2@gmail.com" } ]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  @github_url Application.get_env(:ghissues, :github_url)

  def issues_url(url, project) do
    "#{ @github_url }/repos/#{ url }/#{ project }/issues"
  end

  def handle_response({ :ok, %{ status_code: 200, body: body }}) do
    { :ok, Poison.Parser.parse!(body) }
  end

  def handle_response({ _, %{ status_code: _, body: body }}) do
    { :error, Poison.Parser.parse! body }
  end
end
