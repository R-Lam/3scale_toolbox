RSpec.describe ThreeScaleToolbox::Commands::MappingRulesCommand::List::ListSubcommand do
  let(:remote) { instance_double('ThreeScale::API::Client', 'remote') }
  let(:service) { instance_double(ThreeScaleToolbox::Entities::Service) }
  let(:service_class) { class_double(ThreeScaleToolbox::Entities::Service).as_stubbed_const }

  let(:options) { {} }
  let(:arguments) do
    {
      service_ref: 'someservice', remote: 'https://destination_key@destination.example.com'
    }
  end
  
  subject { described_class.new(options, arguments, nil) }
  
  context '#run' do
    context 'when service not found' do
      let(:service) { nil }

      it 'invalid options error raised' do
        expect { subject.run }.to raise_error(ThreeScaleToolbox::Error,
                                              /Service someservice does not exist/)
      end
    end
  end
end