# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module PHeReferralTestKit
  module PHeReferralV010
    class TaskReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Task resource from Task read interaction'
      description 'A server SHALL support the Task read interaction.'

      id :ph_ereferral_v010_task_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'Task'
      end

      def scratch_resources
        scratch[:task_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
