title 'Tests to confirm musl libraries exist'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "musl")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-musl' do
  impact 1.0
  title 'Ensure musl libraries exist as expected'
  desc '
  We check that the directories that musl installs are present.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty}
  end

  describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, "bin/musl-gcc")}") do
    its('stdout') { should match /musl\-gcc/ }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "include")}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "lib")}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "share")}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
