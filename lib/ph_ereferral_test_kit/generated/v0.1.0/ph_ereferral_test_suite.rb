# frozen_string_literal: true

require 'base64'
require 'inferno/dsl/oauth_credentials'
require 'inferno_suite_generator/utils/helpers'
require_relative '../../version'

require_relative 'patient_group'
require_relative 'service_request_group'
require_relative 'encounter_group'
require_relative 'ereferral_condition_group'
require_relative 'ereferral_observation_group'
require_relative 'procedure_group'
require_relative 'task_group'
require_relative 'provenance_group'
require_relative 'practitioner_role_group'

module PHeReferralTestKit
  module PHeReferralV010
    class PHeReferralTestSuite < Inferno::TestSuite
      title 'PH eReferral v0.1.0'
      description %(
        The PH eReferral Test Kit tests systems for their conformance to the [PH eReferral](https://fhir.doh.gov.ph/pheref/ImplementationGuide/fhir.ph.ereferral).

        HL7® FHIR® resources are validated with the Java validator using
        https://tx.fhir.org/r4 as the terminology server.

        The test suite is generated using the [InfernoSuiteGenerator](https://github.com/hl7au/inferno_suite_generator) gem version 0.1.1.
      )
      version VERSION

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      fhir_resource_validator do
        igs '/home/igs/0.1.0.tgz'
        message_filters = [
          "The value provided ('xml') was not found in the value set 'MimeType'",
          "The value provided ('json') was not found in the value set 'MimeType'",
          "The value provided ('ttl') was not found in the value set 'MimeType'"
        ] + VERSION_SPECIFIC_MESSAGE_FILTERS

        cli_context do
          txServer ENV.fetch('TX_SERVER_URL', 'https://tx.fhir.org/r4')
          disableDefaultResourceFetcher false
        end

        exclude_message do |message|
          Helpers.is_message_exist_in_list(message_filters, message.message)
        end
      end

      links [
        {
          label: 'Report Issue',
          url: 'https://github.com/UP-Manila-SILab/ph-ereferral-test-kit/issues'
        },
        {
          label: 'Source Code',
          url: 'https://github.com/UP-Manila-SILab/ph-ereferral-test-kit'
        },
        {
          label: 'Implementation Guide',
          url: 'https://fhir.doh.gov.ph/pheref/index.html'
        }
      ]

      id :ph_ereferral_v010

      input :url,
            title: 'FHIR Endpoint',
            description: 'URL of the FHIR endpoint',
            default: 'https://cdr.pheref.fhirlab.net/fhir'
      input :smart_credentials,
            title: 'OAuth Credentials',
            type: :oauth_credentials,
            optional: true
      input :header_name,
            title: 'Header name',
            optional: true
      input :header_value,
            title: 'Header value',
            optional: true

      fhir_client do
        url :url
        oauth_credentials :smart_credentials
        headers Helpers.get_http_header(header_name, header_value)
      end

      group do
        title 'PH eReferral FHIR API'
        id :ph_ereferral_v010_fhir_api

        group from: :ph_ereferral_v010_patient

        group from: :ph_ereferral_v010_service_request

        group from: :ph_ereferral_v010_encounter

        group from: :ph_ereferral_v010_ereferral_condition

        group from: :ph_ereferral_v010_ereferral_observation

        group from: :ph_ereferral_v010_procedure

        group from: :ph_ereferral_v010_task

        group from: :ph_ereferral_v010_provenance

        group from: :ph_ereferral_v010_practitioner_role
      end
    end
  end
end
