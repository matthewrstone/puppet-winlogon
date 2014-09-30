require 'spec_helper'
describe 'winlogon' do

  context 'with defaults for all parameters' do
    it { should contain_class('winlogon') }
  end
end
