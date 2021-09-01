class UserEvent < ApplicationRecord

  enum event_type: {click: "click", hover: "hover"}

  validates :data, presence: true
  validate :valid_blob, on: :create

  def valid_blob

    errors.add(:data, "missing event_type") unless data&.key?("event_type")
    errors.add(:data, "missing name") unless data&.key?("name")

    errors.add(:data, "invalid event_type") unless UserEvent.event_types[data&.fetch("event_type", nil)]
  end


end
