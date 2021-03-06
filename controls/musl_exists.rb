title 'Tests to confirm musl libraries exist'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "musl")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-musl' do
  impact 1.0
  title 'Ensure musl libraries exist as expected'
  desc '
  To test that the libraries that musl export are in the correct file path, we first find the file path for the package.
  Using this file path we then check for the existance of the directories at the expected location.
    $ ls -al $PKG_PATH/include/asm
      . .. aio.h alloca.h ar.h ...
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty}
    its('exit_status') { should eq 0 }
  end

  describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, "bin/musl-gcc")}") do
    its('stdout') { should match /musl\-gcc/ }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "include")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "lib")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "share")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

end
