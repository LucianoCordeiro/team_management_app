class CreateRole
  attr_reader :name, :error

  def initialize(name:)
    @name = name
  end

  def run
    role.save!
    true
  rescue ActiveRecord::ActiveRecordError => e
    @error = e.message
    false
  end

  def role
    @role ||= Role.new(name: name)
  end
end
