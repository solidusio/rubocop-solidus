# frozen_string_literal: true

RSpec.describe RuboCop::Cop::TargetSolidusVersion do
  include FileHelper

  let(:base_cop) { RuboCop::Cop::BaseCop }
  let(:dummy_cop) { base_cop.include(RuboCop::Cop::TargetSolidusVersion).new(config) }

  let(:config) { RuboCop::Config.new(hash, loaded_path) }
  let(:hash) { {} }
  let(:loaded_path) { 'example/.rubocop.yml' }

  before do
    stub_const('RuboCop::Cop::BaseCop', Class.new(RuboCop::Cop::Base))
  end

  describe '#add_offense' do
    shared_examples 'affected solidus version' do
      it 'calls the super method' do
        expect_any_instance_of(RuboCop::Cop::Base).to receive(:add_offense)
        expect(dummy_cop.add_offense).to eq 'Super called'
      end
    end

    shared_examples 'not affected solidus version' do
      it 'does not call the super method' do
        expect_any_instance_of(RuboCop::Cop::Base).to_not receive(:add_offense)
        expect(dummy_cop.add_offense).to be_nil
      end
    end

    before do
      allow_any_instance_of(RuboCop::Cop::Base).to receive(:add_offense).and_return('Super called')
    end

    context 'when TargetSolidusVersion is set' do
      let(:hash) { { 'TargetSolidusVersion' => solidus_version } }

      before do
        allow(dummy_cop.config).to receive(:for_all_cops).and_return(hash)
        dummy_cop.class.minimum_solidus_version 2.5
      end

      context 'and TargetSolidusVersion is lower than minimum_solidus_version' do
        let(:solidus_version) { '2.4' }

        it_behaves_like 'not affected solidus version'
      end

      context 'and TargetSolidusVersion is bigger than minimum_solidus_version' do
        let(:solidus_version) { '2.6' }

        it_behaves_like 'affected solidus version'
      end
    end

    context 'when TargetSolidusVersion is not set' do
      context 'and lock files do not exist' do
        context 'and default solidus version is lower than minimum_solidus_version' do
          before do
            dummy_cop.class.minimum_solidus_version 3.1
          end

          it_behaves_like 'not affected solidus version'
        end

        context 'and default solidus version is bigger than minimum_solidus_version' do
          before do
            dummy_cop.class.minimum_solidus_version 2.11
          end

          it_behaves_like 'affected solidus version'
        end
      end

      context 'and Gemfile.lock exists', :isolated_environment do
        let(:base_path) { dummy_cop.config.base_dir_for_path_parameters }
        let(:lock_file_path) { File.join(base_path, 'Gemfile.lock') }

        before do
          dummy_cop.class.minimum_solidus_version 3.3
          create_file(lock_file_path, content)
          allow(dummy_cop.config).to receive(:bundler_lock_file_path).and_return(lock_file_path)
        end

        context 'and solidus version is lower than minimum_solidus_version' do
          let(:content) do
            <<~LOCKFILE
              GEM
                remote: https://rubygems.org/
                specs:
                  solidus (3.2.8)
                    solidus_api (= 3.2.8)
                    solidus_backend (= 3.2.8)
                    solidus_core (= 3.2.8)
                    solidus_frontend (= 3.2.8)
                    solidus_sample (= 3.2.8)
                  solidus_core (3.2.8)

              PLATFORMS
                ruby

              DEPENDENCIES
                solidus (~> 3.2.0)

              BUNDLED WITH
                2.3.22
            LOCKFILE
          end

          it_behaves_like 'not affected solidus version'
        end

        context 'and solidus version is bigger than minimum_solidus_version' do
          let(:content) do
            <<~LOCKFILE
              GEM
                remote: https://rubygems.org/
                specs:
                  solidus (3.4.3)
                    solidus_api (= 3.4.3)
                    solidus_backend (= 3.4.3)
                    solidus_core (= 3.4.3)
                    solidus_frontend (= 3.4.3)
                    solidus_sample (= 3.4.3)
                  solidus_core (3.4.3)

              PLATFORMS
                ruby

              DEPENDENCIES
                solidus (~> 3.4.0)

              BUNDLED WITH
                2.3.22
            LOCKFILE
          end

          it_behaves_like 'affected solidus version'
        end
      end
    end
  end
end
