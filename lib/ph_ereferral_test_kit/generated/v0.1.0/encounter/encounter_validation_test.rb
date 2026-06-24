# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/validation_test'

module PHeReferralTestKit
  module PHeReferralV010
    class EncounterValidationTest < Inferno::Test
      include InfernoSuiteGenerator::ValidationTest

      id :ph_ereferral_v010_encounter_validation_test
      title 'Encounter resources returned during previous tests conform to the ERefEncounter'
      description %(
This test verifies resources returned from the first search conform to
the [ERefEncounter](https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-encounter).
If at least one resource from the first search is invalid, the test will fail.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Encounter'
      end

      def scratch_resources
        scratch[:encounter_resources] ||= {}
      end

      def filter_set
        []
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-encounter',
                                '0.1.0',
                                skip_if_empty: true)
      end
    end
  end
end
