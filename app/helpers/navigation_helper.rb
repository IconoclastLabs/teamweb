module NavigationHelper

    def render_breadcrumbs
        # Build breadcrumbs along association when applicable
        navigation_add "Organizations", organizations_path if @organizations || @organization
        navigation_add @organization.name, organization_path(@organization) if defined?(@organization) && @organization.id
        navigation_add "Seasons", organization_seasons_path(@organization) if @seasons || @season
        navigation_add @season.name, organization_season_path(@organization, @season) if defined?(@season) && @season.id
        navigation_add "Events", organization_season_events_path(@organization, @season)  if @events || @event
        navigation_add @event.name, organization_season_event_path(@season.organization, @season, @event) if defined?(@event) && @event.id
        navigation_add "Teams", organization_season_teams_path(@organization, @season) if @teams || @team
        navigation_add @team.name, organization_season_team_path(@organization, @season, @team) if defined?(@team) && @team.id

        render :partial => 'shared/navigation', :locals => { :nav => ensure_navigation }
    end

    def nav_link(link_text, link_path, link_options = {})
      class_name = current_page?(link_path) ? 'active' : ''

      content_tag(:li, class: class_name) do 
        link_to link_text, link_path, link_options        
      end
    end

    private

    def ensure_navigation
        @navigation ||= [ ]
    end

    def navigation_add(title, url)
        ensure_navigation << { :title => title, :url => url }
    end
end