require 'spec_helper'


describe service('syncthing') do
   it { should be_enabled   }
   it { should be_running   }
end

describe port(8080) do
  it { should be_listening }
end

describe file('/etc/init/syncthing.conf') do
  it { should be_file }
  # its(:content) { should match /name=syncthing/ }
  # its(:content) { should match /rcval=syncthing_enable/ }
end

describe file('/etc/init.d/syncthing') do
  it { should be_linked_to '/etc/init/syncthing.conf' }
end
