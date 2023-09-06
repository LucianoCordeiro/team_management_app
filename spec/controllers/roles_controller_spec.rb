
 require 'rails_helper'

 RSpec.describe 'Role', type: :request do

   context 'role creation' do
     let!(:action) { double("action") }

     before { allow(CreateRole).to receive(:new).and_return(action) }

     def request!
       post(
         "/roles",
         params: {
           name: "Tester"
         }
       )
     end

     it 'successful' do
       allow(action).to receive(:run).and_return true
       allow(action).to receive(:role).and_return(Role.create(name: "Tester"))

       request!

       expect(CreateRole).to have_received(:new).with(
         name: "Tester",
       )

       expect(response.status).to eql 200
       expect(response.body).to eql(
         {
           role: Role.find_by(name: "Tester")
         }.to_json
       )
     end

     it 'failed' do
       allow(action).to receive(:run).and_return false
       allow(action).to receive(:error).and_return("This role already exists")

       request!

       expect(CreateRole).to have_received(:new).with(
         name: "Tester",
       )

       expect(response.status).to eql 400
       expect(response.body).to eql(
         {
           error: "This role already exists"
         }.to_json
       )
     end
   end

   context 'list memberships' do
     let!(:action) { double("action") }

     let(:role) { Role.create(name: "Tester") }
     let(:team) { FactoryBot.create(:team) }
     let(:member) { FactoryBot.create(:user) }

     before do
       allow(FindRoleMemberships).to receive(:new).and_return(action)

       Membership.create(
         member: member,
         team: team,
         role: role
       )
    end

     def request!
       get(
         "/roles/#{role.id}/memberships"
       )
     end

     it 'successful' do
       allow(action).to receive(:run).and_return true
       allow(action).to receive(:memberships).and_return(role.memberships)

       request!

       expect(response.status).to eql 200
       expect(response.body).to eql(
         {
           memberships: role.memberships
         }.to_json
       )
     end

     it 'failed' do
       allow(action).to receive(:run).and_return false
       allow(action).to receive(:error).and_return("Role not found")

       request!

       expect(response.status).to eql 404
       expect(response.body).to eql(
         {
           error: "Role not found"
         }.to_json
       )
     end
   end
 end
