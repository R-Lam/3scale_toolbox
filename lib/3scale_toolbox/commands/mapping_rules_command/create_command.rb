module ThreeScaleToolbox
    module Commands
      module MappingRulesCommand
        module Create
          class CustomPrinter
  
            def print_record(mapping_rule)
              puts "Created mapping_rule id: #{mapping_rule['id']}."
            end
  
            def print_collection(collection) end
          end
  
          class CreateSubcommand < Cri::CommandRunner
            include ThreeScaleToolbox::Command
  
            def self.command
              Cri::Command.define do
                name        'create'
                usage       'create [opts] <remote> <service>'
                summary     'create Mapping Rule'
                description 'Create Mapping Rule'
  
                option      :m, :'http-method', 'Specify HTTP Method to use. Default GET', default: 'GET', argument: :required
                option      :p, :pattern, 'Mapping Rule pattern. Default /', default: '/', argument: :required
                option      :d, :delta, 'Increase the metric by this delta. Default 1', default: '1', argument: :required
                option      :i, :'metric-id', 'Metric ID.', argument: :required
                option      :x, :position, 'Mapping Rule position. Default 0', default: '0', argument: :required
                option      :l, :last, 'Last matched Mapping Rule to process. Default false', default: 'false', argument: :required
                ThreeScaleToolbox::CLI.output_flag(self)
  
                param       :remote
                param       :service_ref
  
                runner CreateSubcommand
              end
            end
  
            def run
              mapping_rule = ThreeScaleToolbox::Entities::MappingRule.create(
                service: service,
                attrs: mapping_rule_attrs
              )
  
              printer.print_record mapping_rule.attrs
            end
  
            private
  
            def mapping_rule_attrs
              {
                'system_name' => options[:'system-name'],
                'http_method' => options[:'http-method'],
                'pattern' => options[:pattern],
                'delta' => options[:delta],
                'metric_id' => options[:'metric-id'],
                'position' => options[:position],
                'last' => options[:last]
              }.compact
            end
  
            def service
              @service ||= find_service
            end
  
            def find_service
              Entities::Service.find(remote: remote,
                                     ref: service_ref).tap do |svc|
                raise ThreeScaleToolbox::Error, "Service #{service_ref} does not exist" if svc.nil?
              end
            end
  
            def remote
              @remote ||= threescale_client(arguments[:remote])
            end
  
            def service_ref
              arguments[:service_ref]
            end
  
            def printer
              # keep backwards compatibility
              options.fetch(:output, CustomPrinter.new())
            end
          end
        end
      end
    end
  end
  