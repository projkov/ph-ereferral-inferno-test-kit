# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHeReferralTestKit
  module PHeReferralV010
    class ServiceRequestMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the ServiceRequest resources returned'
      description %(
        PH eReferral Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH eReferral Server Capability
        Statement. This test will look through the ServiceRequest resources
        found previously for the following must support elements:

        * ServiceRequest.asNeeded[x]:asNeededCodeableConcept
        * ServiceRequest.asNeeded[x]:asNeededCodeableConcept.coding
        * ServiceRequest.asNeeded[x]:asNeededCodeableConcept.text
        * ServiceRequest.authoredOn
        * ServiceRequest.bodySite
        * ServiceRequest.bodySite.coding
        * ServiceRequest.bodySite.text
        * ServiceRequest.category
        * ServiceRequest.code
        * ServiceRequest.code.coding
        * ServiceRequest.code.text
        * ServiceRequest.encounter
        * ServiceRequest.intent
        * ServiceRequest.locationCode
        * ServiceRequest.locationCode.coding
        * ServiceRequest.locationCode.text
        * ServiceRequest.note
        * ServiceRequest.occurrence[x]
        * ServiceRequest.occurrence[x]:occurrenceDateTime
        * ServiceRequest.orderDetail
        * ServiceRequest.orderDetail.coding
        * ServiceRequest.orderDetail.text
        * ServiceRequest.performer
        * ServiceRequest.performerType
        * ServiceRequest.performerType.coding
        * ServiceRequest.performerType.text
        * ServiceRequest.reasonCode
        * ServiceRequest.reasonCode.coding
        * ServiceRequest.reasonCode.text
        * ServiceRequest.reasonReference
        * ServiceRequest.relevantHistory
        * ServiceRequest.requester
        * ServiceRequest.status
        * ServiceRequest.subject
        * ServiceRequest.supportingInfo
      )

      id :ph_ereferral_v010_service_request_must_support_test

      def resource_type
        'ServiceRequest'
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

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
