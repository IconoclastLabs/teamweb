json.array!(@seasons) do |season|
  json.extract! season, :name, :start, :end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size
  json.url season_url(season, format: :json)
end
