# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHeReferralTestKit
  module PHeReferralV010
    class EncounterMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Encounter resources returned'
      description %(
        PH eReferral Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH eReferral Server Capability
        Statement. This test will look through the Encounter resources
        found previously for the following must support elements:

        * Encounter.class
        * Encounter.diagnosis.use
        * Encounter.diagnosis.use.coding
        * Encounter.diagnosis.use.text
        * Encounter.hospitalization
        * Encounter.hospitalization.admitSource
        * Encounter.hospitalization.admitSource.coding
        * Encounter.hospitalization.admitSource.text
        * Encounter.hospitalization.dietPreference
        * Encounter.hospitalization.dietPreference.coding
        * Encounter.hospitalization.dietPreference.text
        * Encounter.hospitalization.dischargeDisposition
        * Encounter.hospitalization.origin
        * Encounter.hospitalization.reAdmission
        * Encounter.hospitalization.reAdmission.coding
        * Encounter.hospitalization.reAdmission.text
        * Encounter.hospitalization.specialArrangement
        * Encounter.hospitalization.specialArrangement.coding
        * Encounter.hospitalization.specialArrangement.text
        * Encounter.hospitalization.specialCourtesy
        * Encounter.hospitalization.specialCourtesy.coding
        * Encounter.hospitalization.specialCourtesy.text
        * Encounter.identifier
        * Encounter.location
        * Encounter.location.location
        * Encounter.location.physicalType
        * Encounter.location.physicalType.coding
        * Encounter.location.physicalType.text
        * Encounter.participant
        * Encounter.participant.type
        * Encounter.period
        * Encounter.period.start
        * Encounter.priority
        * Encounter.priority.coding
        * Encounter.priority.text
        * Encounter.reasonCode
        * Encounter.reasonReference
        * Encounter.serviceProvider
        * Encounter.serviceType
        * Encounter.serviceType.coding
        * Encounter.serviceType.text
        * Encounter.status
        * Encounter.subject
        * Encounter.type
      )

      id :ph_ereferral_v010_encounter_must_support_test

      def resource_type
        'Encounter'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:encounter_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
