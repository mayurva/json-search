require_relative '../../lib/users.rb'

describe 'Users' do
  context '#search fields' do
    it 'returns the valid search fields' do
      search_fields = Users.search_fields
      expect(search_fields)
        .to eq(%w[
                 _id url external_id name alias created_at active verified shared locale timezone
                 last_login_at email phone signature organization_id tags suspended role
               ])
    end
  end

  context '#descriptive fields' do
    it 'returns descriptive fields' do
      descriptive_fields = Users.descriptive_fields
      expect(descriptive_fields)
        .to eq(%w[name alias signature])
    end
  end
end
