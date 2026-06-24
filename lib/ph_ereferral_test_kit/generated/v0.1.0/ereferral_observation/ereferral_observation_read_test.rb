# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module PHeReferralTestKit
  module PHeReferralV010
    class EreferralObservationReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Observation resource from Observation read interaction'
      description 'A server SHALL support the Observation read interaction.'

      input :observation_ids,
            title: 'Observation IDs',
            description: 'Comma separated list of observation IDs that in sum contain all MUST SUPPORT elements',
            default: '',
            optional: true

      id :ph_ereferral_v010_ereferral_observation_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:ereferral_observation_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
