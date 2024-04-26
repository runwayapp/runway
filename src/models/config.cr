require "yaml"

# https://crystal-lang.org/api/1.12.1/YAML/Serializable.html

class RunwayConfiguration
  include YAML::Serializable
  property projects : Array(ProjectConfig)
end

# A project is a collection of events that trigger deployments and are run on a schedule
class ProjectConfig
  include YAML::Serializable
  property name : String
  property type : String
  property location : String
  property path : String
  property events : Array(Event)
end

# An event is a trigger for a deployment for a project
class Event
  include YAML::Serializable
  property type : String
  property repo : String?
  property environment : String?
  property schedule : Schedule
end

# A schedule contains information about how often an event should be checked
class Schedule
  include YAML::Serializable
  property interval : String
  property timezone : String?
end
