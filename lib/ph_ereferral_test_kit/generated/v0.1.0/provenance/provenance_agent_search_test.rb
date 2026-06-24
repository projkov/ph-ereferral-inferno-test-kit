# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/search_test'
require 'inferno_suite_generator/core/group_metadata'
require 'inferno_suite_generator/utils/helpers'

module PHeReferralTestKit
  module PHeReferralV010
    class ProvenanceAgentSearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(MAY) Server returns valid results for Provenance search by agent'
      description %(
A server MAY support searching by
agent on the Provenance resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[PH eReferral Server CapabilityStatement](https://fhir.doh.gov.ph/pheref/CapabilityStatement/ph-ereferral-server)

      )

      id :ph_ereferral_v010_provenance_agent_search_test
      optional

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          resource_type: 'Provenance',
          search_param_names: ['agent']
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:provenance_resources] ||= {}
      end

      def keep_all_search_results?
        false
      end

      run do
        run_search_test
      end
    end
  end
end
