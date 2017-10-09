require_relative '../../lib/tickets.rb'

describe 'Organizations' do
  context '#search fields' do
    it 'returns the valid search fields' do
      search_fields = Tickets.search_fields
      expect(search_fields)
        .to eq(%w[
                 _id url external_id created_at type subject description priority status recipient
                 submitter_id assignee_id organization_id tags has_incidents due_at via requester_id
               ])
    end
  end

  context '#descriptive fields' do
    it 'returns descriptive fields' do
      descriptive_fields = Tickets.descriptive_fields
      expect(descriptive_fields)
        .to eq(%w[subject description])
    end
  end
end
