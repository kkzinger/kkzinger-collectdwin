require 'spec_helper'
describe 'conwin_collectdwin_' do

  context 'with defaults for all parameters' do
    it { should contain_class('conwin_collectdwin_') }
  end
end
