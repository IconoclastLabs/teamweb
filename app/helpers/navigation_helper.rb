module NavigationHelper
    def ensure_navigation
        @navigation ||= [ ]
    end

    def navigation_add(title, url)
        ensure_navigation << { :title => title, :url => url }
    end

    def render_breadcrumbs
        # Build breadcrumbs along association when applicable
        navigation_add "Coordinators", coordinators_path if @coordinators || @coordinator
        navigation_add @coordinator.name, coordinator_path(@coordinator) if defined?(@coordinator) && @coordinator.id
        navigation_add "Events", coordinator_events_path(@coordinator)  if @events || @event
        navigation_add @event.name, coordinator_event_path(@event.coordinator, @event) if defined?(@event) && @event.id
        navigation_add "Teams", coordinator_event_teams_path(@coordinator, @event) if @teams || @team
        navigation_add @team.name, coordinator_event_team_path(@coordinator, @event, @team) if defined?(@team) && @team.id

        render :partial => 'shared/navigation', :locals => { :nav => ensure_navigation }
    end

    def nav_link(link_text, link_path, link_options = {})
      class_name = current_page?(link_path) ? 'active' : ''

      content_tag(:li, class: class_name) do 
        link_to link_text, link_path, link_options        
      end
    end
end