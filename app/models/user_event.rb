# I wouldve actually just made this polymorphic from the beginning, but I don't
# want to deal with refactoring now.
class UserEvent < ApplicationRecord

  # I guess add more
  enum event_type: { click: "click", hover: "hover" }

  validates :data, presence: true
  validate :valid_blob, on: :create

  def valid_blob
    errors.add(:data, "missing event_type") unless data&.key?("event_type")
    errors.add(:data, "missing name") unless data&.key?("name")

    errors.add(:data, "invalid event_type") unless UserEvent.event_types[data&.fetch("event_type", nil)]
  end

  def self.stats_on_day(date)

    todays_events = UserEvent.where("DATE(created_at) = ?", date)
    grouped_events = todays_events.group("data ->> 'event_type'")
                                  .select("data ->> 'event_type' as event_type, count(id)")

    big_hash = ActiveRecord::Base.connection
                                 .exec_query(grouped_events.to_sql)
                                 .rows.to_h

    big_hash.entries.map { |key, value| { key => value } }
  end

  def self.todays_stats
    self.stats_on_day(Date.today)
  end

end
