require "yaml"

# The `RunwayConfiguration` class represents the configuration for the Runway service.
# It includes an array of `ProjectConfig` objects, each representing a project's configuration.
#
# @see https://crystal-lang.org/api/1.12.1/YAML/Serializable.html
class RunwayConfiguration
  include YAML::Serializable

  # @return [Array(ProjectConfig)] The array of project configurations.
  property projects : Array(ProjectConfig)
end

# The `ProjectConfig` class represents the configuration for a project.
# A project is a collection of events that trigger deployments and are run on a schedule.
# It includes properties for the project's name, type, location, path, and events.
class ProjectConfig
  include YAML::Serializable

  # @return [String] The name of the project.
  property name : String

  # @return [String] The type of the project.
  property type : String

  # @return [String] The location of the project.
  property location : String

  # @return [String] The path of the project.
  property path : String

  # @return [Array(Event)] The array of events for the project.
  property events : Array(Event)
end

# The `Event` class represents an event that triggers a deployment for a project.
# It includes properties for the event's type, repository, environment, and schedule.
class Event
  include YAML::Serializable

  # @return [String] The type of the event.
  property type : String

  # @return [String, nil] The repository for the event, or `nil` if not specified.
  property repo : String?

  # @return [String, nil] The environment for the event, or `nil` if not specified.
  property environment : String?

  # @return [Schedule] The schedule for the event.
  property schedule : Schedule
end

# The `Schedule` class represents the schedule for an event.
# It includes properties for the schedule's interval and timezone.
class Schedule
  include YAML::Serializable

  # @return [String] The interval for the schedule.
  property interval : String

  # @return [String, nil] The timezone for the schedule, or `nil` if not specified.
  property timezone : String?
end