# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/validation_test'

module PHeReferralTestKit
  module PHeReferralV010
    class ProvenanceValidationTest < Inferno::Test
      include InfernoSuiteGenerator::ValidationTest

      id :ph_ereferral_v010_provenance_validation_test
      title 'Provenance resources returned during previous tests conform to the EReferral Provenance'
      description %(
This test verifies resources returned from the first search conform to
the [EReferral Provenance](https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-provenance).
If at least one resource from the first search is invalid, the test will fail.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Provenance'
      end

      def scratch_resources
        scratch[:provenance_resources] ||= {}
      end

      def filter_set
        []
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-provenance',
                                '0.1.0',
                                skip_if_empty: true)
      end
    end
  end
end
