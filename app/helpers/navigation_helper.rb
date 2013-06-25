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
        navigation_add @coordinator.name, coordinator_path(@coordinator) if @coordinator
        navigation_add "Events", coordinator_events_path(@coordinator)  if @events || @event
        navigation_add @event.name, coordinator_event_path(@event.coordinator, @event) if @event
        navigation_add "Teams", coordinator_event_teams_path(@coordinator, @event) if @teams || @team
        navigation_add @team.name, coordinator_event_team_path(@coordinator, @event, @team) if @team

        render :partial => 'shared/navigation', :locals => { :nav => ensure_navigation }
    end
end