require_relative '../../lib/users.rb'

describe 'Users' do
  before do
    @filename = 'users.json'
    @user_list =
      '[{"_id": 1,"url": "http://example.com/users/1.json","external_id": "a1","name": "John Doe","role": "admin"},'\
      '{"_id": 2,"url": "http://example.com/users/2.json","external_id": "b2","name": "Jane Doe","role": "admin"}]'
  end
  context '#initialize' do
    it 'receives a filename' do
      expect(Users).to receive(:new).with('users.json')
      Users.new @filename
    end

    it 'opens and parses the file' do
      allow(File).to receive(:read).with('users.json').and_return(@user_list)
      expect(File).to receive(:read).with('users.json')
      users = Users.new @filename
      expect(users.user_list.size).to be(2)
    end

    it 'populates the userlist' do
      allow(File).to receive(:read).with('users.json').and_return(@user_list)
      users = Users.new @filename
      expect(users.user_list.size).to be(2)
      expect(users.user_list[0]['_id']).to be(1)
      expect(users.user_list[1]['name']).to eq('Jane Doe')
    end
  end

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

  context '#search' do
    before do
      allow(File).to receive(:read).with(@filename).and_return(@user_list)
      @users = Users.new @filename
    end
    it 'searches the users for given field' do
      result = @users.search('_id', '1')
      expect(result.size).to be(1)
      expect(result[0]['_id']).to eq(1)
      expect(result[0]['name']).to eq('John Doe')
    end

    it 'returns multiple matches' do
      result = @users.search('role', 'admin')
      expect(result.size).to be(2)
      expect(result[0]['_id']).to eq(1)
      expect(result[0]['role']).to eq('admin')
      expect(result[1]['name']).to eq('Jane Doe')
    end
  end
end
