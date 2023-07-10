# frozen_string_literal: true

RSpec.describe RuboCop::Cop::TargetSolidusVersion do
  include FileHelper

  let(:base_cop) { RuboCop::Cop::BaseCop }
  let(:dummy_cop) { base_cop.include(RuboCop::Cop::TargetSolidusVersion).new }

  before do
    stub_const('RuboCop::Cop::BaseCop', Class.new(RuboCop::Cop::Base))
  end

  describe '#target_solidus_version' do
    context 'when TargetSolidusVersion is set' do
      let(:hash) { { 'TargetSolidusVersion' => solidus_version } }

      before do
        allow(dummy_cop.config).to receive(:for_all_cops).and_return(hash)
      end

      context 'with patch version' do
        let(:solidus_version) { '2.11.5' }
        let(:solidus_version_to_f) { 2.11 }

        it 'truncates the patch part and converts to a float' do
          expect(dummy_cop.target_solidus_version).to eq solidus_version_to_f
        end
      end

      context 'correctly' do
        let(:solidus_version) { '2.11' }
        let(:solidus_version_to_f) { 2.11 }

        it 'uses TargetSolidusVersion' do
          expect(dummy_cop.target_solidus_version).to eq solidus_version_to_f
        end
      end
    end

    context 'when TargetSolidusVersion is not set', :isolated_environment do
      context 'and lock files do not exist' do
        it 'uses the default Solidus version' do
          default = described_class::DEFAULT_SOLIDUS_VERSION
          expect(dummy_cop.target_solidus_version).to eq default
        end
      end

      context 'and Gemfile.lock exists' do
        let(:base_path) { dummy_cop.config.base_dir_for_path_parameters }
        let(:lock_file_path) { File.join(base_path, 'Gemfile.lock') }

        before do
          allow(dummy_cop.config).to receive(:bundler_lock_file_path).and_return(lock_file_path)
        end

        it 'uses the Solidus version in Gemfile.lock' do
          content =
            <<~LOCKFILE
              GEM
                remote: https://rubygems.org/
                specs:
                  solidus (3.1.9)
                    solidus_api (= 3.1.9)
                    solidus_backend (= 3.1.9)
                    solidus_core (= 3.1.9)
                    solidus_frontend (= 3.1.9)
                    solidus_sample (= 3.1.9)
                  solidus_core (3.1.9)

              PLATFORMS
                ruby

              DEPENDENCIES
                solidus (~> 3.1.0)

              BUNDLED WITH
                2.3.22
            LOCKFILE
          create_file(lock_file_path, content)
          expect(dummy_cop.target_solidus_version).to eq 3.1
        end

        it 'uses the default Solidus when Solidus is not in Gemfile.lock' do
          content =
            <<~LOCKFILE
              GEM
                remote: https://rubygems.org/
                specs:
                  bump (0.5.4)

              PLATFORMS
                ruby

              DEPENDENCIES
                bump

              BUNDLED WITH
                2.3.22
            LOCKFILE
          create_file(lock_file_path, content)
          default = described_class::DEFAULT_SOLIDUS_VERSION
          expect(dummy_cop.target_solidus_version).to eq default
        end
      end
    end
  end

  describe '#affected_solidus_version?' do
    context 'when target_solidus_version is lower than minimum_solidus_version' do
      it 'returns false' do
        dummy_cop.class.minimum_solidus_version 3.1
        expect(dummy_cop.affected_solidus_version?).to be false
      end
    end

    context 'when target_solidus_version is greater than minimum_solidus_version' do
      it 'returns true' do
        dummy_cop.class.minimum_solidus_version 2.11
        expect(dummy_cop.affected_solidus_version?).to be true
      end
    end
  end
end
