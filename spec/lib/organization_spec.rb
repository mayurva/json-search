require_relative '../../lib/organizations.rb'

describe 'Organizations' do
  context '#search fields' do
    it 'returns the valid search fields' do
      search_fields = Organizations.search_fields
      expect(search_fields)
        .to eq(%w[
                 _id url external_id name domain_names created_at details shared_tickets tags
               ])
    end
  end

  context '#descriptive fields' do
    it 'returns descriptive fields' do
      descriptive_fields = Organizations.descriptive_fields
      expect(descriptive_fields)
        .to eq(%w[name details])
    end
  end
end
