require 'spec_helper'

RSpec.describe Gbooks::Presenter do
  describe '#print_volumes' do
    context 'when there is at least one volume' do
      it 'does print the list of volumes' do
        volumes = JSON.parse(File.read('spec/fixtures/volumes.json'))['items'].first(3)
        output_stream = double
        expected_output = "1: Harry Potter and the Sorcerer's Stone\n" +
          "2: Harry Potter\n" +
          "3: Harry Potter and the Philosopher's Stone"
        presenter = Gbooks::Presenter.new(output_stream)

        expect(output_stream).to receive(:write).with(expected_output)

        presenter.print_volumes(volumes)
      end
    end

    context 'when there are no volumes' do
      it 'does print a message to inform the user that there are no volumes' do
        volumes = nil
        output_stream = double
        expected_output = 'No results were found.'
        presenter = Gbooks::Presenter.new(output_stream)

        expect(output_stream).to receive(:write).with(expected_output)

        presenter.print_volumes(volumes)
      end
    end
  end
end
