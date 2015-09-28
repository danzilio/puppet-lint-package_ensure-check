require 'spec_helper'

describe 'package_ensure' do
  let (:msg) { 'ensure set to latest on a package resource' }
  context 'with fix disabled' do

    context 'good package resource declarations' do
      let (:code) {
        <<-EOS
        package { 'foopackage1':
          ensure => installed,
        }

        package { 'foopackage2':
          ensure => $latest,
        }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'bad package resource declarations' do
      let (:code) {
        <<-EOS
        package { 'foopackage1':
          ensure => latest,
        }

        package { 'foopackage2':
          ensure => $latest,
        }
        EOS
      }

      it 'should detect problems' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(2).in_column(21)
        expect(problems).not_to contain_warning(msg).on_line(6).in_column(21)
      end
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    context 'good package resource declarations' do
      let (:code) {
        <<-EOS
        package { 'foopackage1':
          ensure => installed,
        }

        package { 'foopackage2':
          ensure => $latest,
        }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end

      it 'should not modify the manifest' do
        expect(manifest).to eq(code)
      end
    end

    context 'bad package resource declarations' do
      let (:code) {
        <<-EOS
        package { 'foopackage1':
          ensure => latest,
        }

        package { 'foopackage2':
          ensure => $latest,
        }
        EOS
      }

      it 'should detect problems' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_fixed(msg).on_line(2).in_column(21)
        expect(problems).not_to contain_fixed(msg).on_line(6).in_column(21)
      end

      it 'should fix the ensure parameter' do
        expect(manifest).to eq(
          <<-EOS
        package { 'foopackage1':
          ensure => installed,
        }

        package { 'foopackage2':
          ensure => $latest,
        }
          EOS
        )
      end
    end
  end
end
