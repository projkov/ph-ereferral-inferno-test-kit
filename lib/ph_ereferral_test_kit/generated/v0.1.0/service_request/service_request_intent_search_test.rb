# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/search_test'
require 'inferno_suite_generator/core/group_metadata'
require 'inferno_suite_generator/utils/helpers'

module PHeReferralTestKit
  module PHeReferralV010
    class ServiceRequestIntentSearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(MAY) Server returns valid results for ServiceRequest search by intent'
      description %(
A server MAY support searching by
intent on the ServiceRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[PH eReferral Server CapabilityStatement](https://fhir.doh.gov.ph/pheref/CapabilityStatement/ph-ereferral-server)

      )

      id :ph_ereferral_v010_service_request_intent_search_test
      optional

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          resource_type: 'ServiceRequest',
          search_param_names: ['intent'],
          possible_status_search: true
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:service_request_resources] ||= {}
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
