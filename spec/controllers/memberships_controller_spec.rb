
 require 'rails_helper'

 RSpec.describe 'Membership', type: :request do

   let!(:action) { double("action") }

   let(:role) { Role.create(name: "Tester") }
   let(:team) { FactoryBot.create(:team) }
   let(:member) { FactoryBot.create(:user) }
   let(:membership) do
     Membership.create(
       member: member,
       team: team,
       role: role
     )
   end

   context 'role assignment' do
     before { allow(AssignRoleToMembership).to receive(:new).and_return(action) }

     def request!
       put(
         "/users/#{member.id}/memberships/#{membership.id}/assign_role",
         params: {
           role_id: role.id
         }
       )
     end

     it 'successful' do
       allow(action).to receive(:run).and_return true
       allow(action).to receive(:membership).and_return(membership)

       request!

       expect(AssignRoleToMembership).to have_received(:new).with(
         role_id: role.id,
         member_id: member.id,
         membership_id: membership.id.to_s
       )

       expect(response.status).to eql 200
       expect(response.body).to eql(
         {
           membership: membership
         }.to_json
       )
     end

     it 'failed' do
       allow(action).to receive(:run).and_return false
       allow(action).to receive(:error).and_return("Role not found")

       request!

       expect(AssignRoleToMembership).to have_received(:new).with(
         role_id: role.id,
         member_id: member.id,
         membership_id: membership.id.to_s
       )

       expect(response.status).to eql 404
       expect(response.body).to eql(
         {
           error: "Role not found"
         }.to_json
       )
     end
   end

   context 'find role' do
     before { allow(FindMembershipRole).to receive(:new).and_return(action) }

     def request!
       get(
         "/users/#{member.id}/memberships/#{membership.id}/find_role"
       )
     end

     it 'successful' do
       allow(action).to receive(:run).and_return true
       allow(action).to receive(:role_name).and_return("Tester")

       request!

       expect(FindMembershipRole).to have_received(:new).with(
         member_id: member.id,
         membership_id: membership.id.to_s
       )

       expect(response.status).to eql 200
       expect(response.body).to eql(
         {
           role_name: "Tester"
         }.to_json
       )
     end

     it 'failed' do
       allow(action).to receive(:run).and_return false
       allow(action).to receive(:error).and_return("Role Not Found")

       request!

       expect(FindMembershipRole).to have_received(:new).with(
         member_id: member.id,
         membership_id: membership.id.to_s
       )

       expect(response.status).to eql 404
       expect(response.body).to eql(
         {
           error: "Role Not Found"
         }.to_json
       )
     end
   end

 end
