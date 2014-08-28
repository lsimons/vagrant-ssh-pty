# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_ENABLE_PATCH=ENV['VAGRANT_ENABLE_PATCH']

unless VAGRANT_ENABLE_PATCH.nil?
  # https://github.com/ryuzee/sandbox-devops/blob/master/vagrant-dynamic-monkey-patch/Vagrantfile
  $plugin_load_proc = lambda do |directory|
    # We only care about directories
    next false if !directory.directory?

    # If there is a plugin file in the top-level directory, then load
    # that up.
    plugin_file = directory.join('plugin.rb')
    if plugin_file.file?
      # STDERR.puts "loading monkey patch: #{plugin_file}"
      load(plugin_file)
      next true
    end
  end

  def patch_vagrant
    patch_dir = File.dirname(__FILE__) + '/vagrant-patch/plugins/communicators/'
    Vagrant.source_root.join(patch_dir).children(true).each do |directory|
      # Ignore non-directories
      next if !directory.directory?

      # Load from this directory, and exit if we successfully loaded a plugin
      next if $plugin_load_proc.call(directory)
    end
  end

  patch_vagrant
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/centos-6.5"

  config.vm.hostname = "vagrant-ssh-pty"

  config.ssh.pty = true

  config.vm.provision :shell, inline: <<-EOF
    echo "PROVISIONED"
  EOF

end
