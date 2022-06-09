RSpec.describe ThreeScaleToolbox::Commands::MappingRulesCommand::Create::CreateSubcommand do
    let(:arguments) do
      {
        service_ref: 'someservice', remote: 'https://destination_key@destination.example.com'
      }
    end
    let(:options) { {} }
    let(:service_class) { class_double(ThreeScaleToolbox::Entities::Service).as_stubbed_const }
    let(:service) { instance_double(ThreeScaleToolbox::Entities::Service) }
    let(:remote) { instance_double(ThreeScale::API::Client, 'remote') }
    let(:mapping_rule_class) { class_double(ThreeScaleToolbox::Entities::MappingRule).as_stubbed_const }
    let(:mapping_rule) { instance_double(ThreeScaleToolbox::Entities::MappingRule) }
    let(:mapping_rule_id) { 1 }
    let(:mapping_rule_attrs) { { 'id' => mapping_rule_id } }
    let(:expected_basic_attrs) do
      {
        'http_method' => 'GET',
        'pattern' => '/',
        'delta' => '1',
        'metric_id' => '2',
        'position' => '1',
        'last' => 'false'
      }
    end
    subject { described_class.new(options, arguments, nil) }
  
    context '#run' do
      before :each do
        allow(mapping_rule).to receive(:attrs).and_return(mapping_rule_attrs)
      end
  
      context 'when service not found' do
        let(:service) { nil }

        before :example do
          expect(service_class).to receive(:find).and_return(service)
          expect(subject).to receive(:threescale_client).and_return(remote)
        end
  
        it 'error raised' do
          expect { subject.run }.to raise_error(ThreeScaleToolbox::Error,
                                                /Service someservice does not exist/)
        end
      end
    end
  end
  