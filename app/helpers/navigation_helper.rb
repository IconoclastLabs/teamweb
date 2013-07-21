module NavigationHelper
    def ensure_navigation
        @navigation ||= [ ]
    end

    def navigation_add(title, url)
        ensure_navigation << { :title => title, :url => url }
    end

    def render_breadcrumbs
        # Build breadcrumbs along association when applicable
        navigation_add "Organizations", organizations_path if @organizations || @organization
        navigation_add @organization.name, organization_path(@organization) if defined?(@organization) && @organization.id
        navigation_add "Events", organization_events_path(@organization)  if @events || @event
        navigation_add @event.name, organization_event_path(@event.organization, @event) if defined?(@event) && @event.id
        navigation_add "Teams", organization_event_teams_path(@organization, @event) if @teams || @team
        navigation_add @team.name, organization_event_team_path(@organization, @event, @team) if defined?(@team) && @team.id

        render :partial => 'shared/navigation', :locals => { :nav => ensure_navigation }
    end

    def nav_link(link_text, link_path, link_options = {})
      class_name = current_page?(link_path) ? 'active' : ''

      content_tag(:li, class: class_name) do 
        link_to link_text, link_path, link_options        
      end
    end
end