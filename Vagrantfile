# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = 'test.local'
proxyUrl = ''

vm = { :hostname => "gogs", :ip => "192.168.0.50", :box => "geerlingguy/centos7", ram: 1024 }

Vagrant.configure("2") do |config|
   config.vm.define vm[:hostname] do |vmconfig|
      vmconfig.vm.provider :virtualbox do |box|
         box.name = vm[:hostname]
         box.customize [
            "modifyvm", :id,
            "--cpuexecutioncap", "50",
            "--memory", vm[:ram].to_s,
            "--cpus", "2",
         ]
      end
      vmconfig.vm.box = vm[:box]
      vmconfig.vm.hostname = vm[:hostname] + "." + domain
      vmconfig.vm.network "forwarded_port", guest: 3000, host: 3000
      vmconfig.vm.network "forwarded_port", guest: 10022, host: 10022
      vmconfig.vm.boot_timeout = 300
      vmconfig.vm.synced_folder "./salt", "/srv/salt", disabled: false

      # bootstrap VM
      vmconfig.vm.provision "shell", path: "bootstrap.sh", args: [vm[:hostname] + "." + domain, proxyUrl]
      vmconfig.vm.provision "shell", path: "bootstrap-salt-minion.sh"

      # execute vm configuration using salt
      if proxyUrl
#         vmconfig.vm.provision "shell", inline: "salt-call --local state.sls pip pillar='{\"proxyUrl\": " + proxyUrl + "}'"
         vmconfig.vm.provision "shell", inline: "salt-call --local state.sls docker pillar='{\"proxyUrl\": " + proxyUrl + "}'"
      else
#         vmconfig.vm.provision "shell", inline: "salt-call --local state.sls pip"
         vmconfig.vm.provision "shell", inline: "salt-call --local state.sls docker"
      end
      vmconfig.vm.provision "shell", inline: "salt-call --local state.sls gogs"
      vmconfig.vm.provision "shell", inline: "docker cp /vagrant/gogs-conf/app.ini gogs:/data/gogs/conf/"
      vmconfig.vm.provision "shell", inline: "docker restart gogs"
      # create administrator user for gogs
      vmconfig.vm.provision "shell", inline: "docker exec gogs su git -c '/app/gogs/gogs admin create-user --name administrator --password gogs --admin --email administrator@test.local'"
#      vmconfig.vm.provision :reload
   end
end