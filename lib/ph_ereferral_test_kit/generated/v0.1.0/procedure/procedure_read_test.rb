# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module PHeReferralTestKit
  module PHeReferralV010
    class ProcedureReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Procedure resource from Procedure read interaction'
      description 'A server SHALL support the Procedure read interaction.'

      input :procedure_ids,
            title: 'Procedure IDs',
            description: 'Comma separated list of procedure IDs that in sum contain all MUST SUPPORT elements',
            default: '',
            optional: true

      id :ph_ereferral_v010_procedure_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'Procedure'
      end

      def scratch_resources
        scratch[:procedure_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
