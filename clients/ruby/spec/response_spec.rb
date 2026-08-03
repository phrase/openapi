require 'spec_helper'

describe Phrase::Response do
  context 'without a link header' do
    it 'is not paginated' do
      response = Phrase::Response.new({ 'foo' => 'bar' }, {})

      expect(response.paginated?).to eq(false)
      expect(response.next_page?).to eq(false)
      expect(response.next_page).to be_nil
    end
  end

  context 'with a link header that has a next page' do
    let(:headers) do
      {
        'link' => '<https://api.phrase.com/v2/projects/project_id/keys?page=2>; rel="next", ' \
                  '<https://api.phrase.com/v2/projects/project_id/keys?page=5>; rel="last"'
      }
    end

    it 'parses the next page number without raising' do
      response = Phrase::Response.new({ 'foo' => 'bar' }, headers)

      expect(response.paginated?).to eq(true)
      expect(response.next_page?).to eq(true)
      expect(response.next_page).to eq(2)
    end
  end

  context 'with a link header that has no next page' do
    let(:headers) do
      {
        'link' => '<https://api.phrase.com/v2/projects/project_id/keys?page=1>; rel="first", ' \
                  '<https://api.phrase.com/v2/projects/project_id/keys?page=1>; rel="last"'
      }
    end

    it 'is paginated but has no next page' do
      response = Phrase::Response.new({ 'foo' => 'bar' }, headers)

      expect(response.paginated?).to eq(true)
      expect(response.next_page?).to eq(false)
      expect(response.next_page).to be_nil
    end
  end

  it 'delegates missing methods to the underlying data' do
    response = Phrase::Response.new({ 'foo' => 'bar' }, {})

    expect(response['foo']).to eq('bar')
  end
end
