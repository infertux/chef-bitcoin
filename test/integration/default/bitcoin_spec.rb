describe command('sudo -u bitcoin -- bitcoin-cli -version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should include 'Bitcoin Core RPC client' }
end
