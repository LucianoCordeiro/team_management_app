require "rails_helper"

RSpec.describe CreateRole do

  it 'create role' do
    expect(Role.find_by(name: "Product Owner")).to be_nil

    action = described_class.new(name: "Product Owner")

    expect(action.run).to be true

    role = Role.find_by(name: "Product Owner")

    expect(role).to be_present
    expect(action.role).to be_persisted
    expect(action.role).to eql role
  end

  it 'role already exists' do
    Role.create(name: "Product Owner")

    expect(Role.find_by(name: "Product Owner")).to be_present

    action = described_class.new(name: "Product Owner")

    expect(action.run).to be false

    expect(action.role).to_not be_persisted
    expect(action.error).to eql "Validation failed: Name has already been taken"
  end

  it 'no name given' do
    action = described_class.new(name: nil)

    expect(action.run).to be false

    expect(action.role).to_not be_persisted
    expect(action.error).to eql "Validation failed: Name can't be blank"
  end
end
