require_relative '../../lib/dataset.rb'

describe 'Dataset' do
  before do
    @filename = 'dataset.json'
    @list =
      '[{"_id": 1,"url": "fake_url1","name": "name1","type": "common_type","tags": ["tag1","tag2"]},'\
      '{"_id": 2,"url": "fake_url2","name": "name2","type": "common_type","tags": ["tag3"]}]'
  end
  context '#initialize' do
    it 'receives a filename' do
      expect(Dataset).to receive(:new).with('dataset.json')
      Dataset.new @filename
    end

    it 'opens and parses the file' do
      allow(File).to receive(:read).with('dataset.json').and_return(@list)
      expect(File).to receive(:read).with('dataset.json')
      data = Dataset.new @filename
      expect(data.list.size).to be(2)
    end

    it 'populates the userlist' do
      allow(File).to receive(:read).with('dataset.json').and_return(@list)
      data = Dataset.new @filename
      expect(data.list.size).to be(2)
      expect(data.list[0]['_id']).to be(1)
      expect(data.list[1]['name']).to eq('name2')
    end
  end

  context '#search' do
    before do
      allow(File).to receive(:read).with(@filename).and_return(@list)
      @data = Dataset.new @filename
    end
    it 'searches the users for given field' do
      result = @data.search('_id', '1')
      expect(result.size).to be(1)
      expect(result[0]['_id']).to eq(1)
      expect(result[0]['name']).to eq('name1')
    end

    it 'returns multiple matches' do
      result = @data.search('type', 'common_type')
      expect(result.size).to be(2)
      expect(result[0]['_id']).to eq(1)
      expect(result[0]['type']).to eq('common_type')
      expect(result[1]['name']).to eq('name2')
    end

    it 'should search through multi-valued fields' do
      result = @data.search('tags', 'tag1')
      expect(result.size).to be(1)
      expect(result[0]['_id']).to eq(1)
      expect(result[0]['name']).to eq('name1')
    end
  end
end
