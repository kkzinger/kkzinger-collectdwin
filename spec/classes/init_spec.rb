require 'spec_helper'
describe 'collectdwin' do

  context 'with defaults for all parameters' do
    it { should contain_class('collectdwin') }
  end
end
