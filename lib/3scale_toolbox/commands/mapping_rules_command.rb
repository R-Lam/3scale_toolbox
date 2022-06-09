require 'cri'
require '3scale_toolbox/base_command'
require '3scale_toolbox/commands/mapping_rules_command/list_command'
#require '3scale_toolbox/commands/mapping_rules_command/create_command'
#require '3scale_toolbox/commands/mapping_rules_command/update_command'
#require '3scale_toolbox/commands/mapping_rules_command/delete_command'

module ThreeScaleToolbox
  module Commands
    module MappingRulesCommand
      include ThreeScaleToolbox::Command

      def self.command
        Cri::Command.define do
          name        'mapping-rules'
          usage       'mapping-rules <sub-command> [options]'
          summary     'mapping-rules super command'
          description 'Mapping Rules configuration commands'

          run do |_opts, _args, cmd|
            puts cmd.help
          end
        end
      end

      add_subcommand(List::ListSubcommand)
#      add_subcommand(CreateSubcommand)
#      add_subcommand(UpdateSubcommand)
#      add_subcommand(DeleteSubcommand)
    end
  end
end