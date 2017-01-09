require 'spec_helper'

RSpec.describe Gbooks::Client do
  FakeHTTPResponse = Struct.new(:body, :code)

  describe '#search_volumes' do
    context 'common' do
      it 'does correctly call the Google Books API volumes search endpoint' do
        client = Gbooks::Client.new
        search = 'Mémoires de la vie privée de Benjamin Franklin'
        uri = URI(URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{search}"))
        fake_response = FakeHTTPResponse.new('{ "key": "value" }', '200')

        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(fake_response)

        client.search_volumes(search)
      end
    end

    context 'when there is an issue with the response' do
      it 'does raise an error' do
        client = Gbooks::Client.new
        search = 'Mémoires de la vie privée de Benjamin Franklin'
        uri = URI(URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{search}"))
        fake_response = FakeHTTPResponse.new('{ "key": "value" }', '500')
        allow(Net::HTTP).to receive(:get_response).with(uri).and_return(fake_response)

        expect { client.search_volumes(search) }.to \
          raise_error(Gbooks::Client::UnexpectedResponseError)
      end
    end
  end
end
