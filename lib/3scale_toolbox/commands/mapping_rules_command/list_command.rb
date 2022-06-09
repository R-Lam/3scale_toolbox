module ThreeScaleToolbox
    module Commands
      module MappingRulesCommand
        module List
          class ListSubcommand < Cri::CommandRunner
            include ThreeScaleToolbox::Command

            FIELDS_TO_SHOW = %w[id metric_id pattern http_method delta position last].freeze

            def self.command
            Cri::Command.define do
              name        'list'
              usage       'list [opts] <remote> <service>'
              summary     'list mapping rules'
              description 'List mapping rules'

              ThreeScaleToolbox::CLI.output_flag(self)
              param       :remote
              param       :service_ref

              runner ListSubcommand
            end
          end

          def run
            printer.print_collection service.mapping_rules.map(&:attrs)
          end

          private

          def remote
            @remote ||= threescale_client(arguments[:remote])
          end

          def service_ref
            arguments[:service_ref]
          end

          def find_service
            Entities::Service.find(remote: remote, ref: service_ref).tap do |svc|
              raise ThreeScaleToolbox::Error, "Service #{service_ref} does not exist" if svc.nil?
            end
          end

          def service
            @service ||= find_service
          end

          def printer
            # keep backwards compatibility
            options.fetch(:output, CLI::CustomTablePrinter.new(FIELDS_TO_SHOW))
          end
        end
      end
    end
  end
end
