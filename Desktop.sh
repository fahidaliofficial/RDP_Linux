name: main
on: 
  workflow_dispatch:
   inputs:
     auth:
        description: 'Code'
        required: true
        default:
  
defaults:
  run:
    shell: bash
jobs:
  build:
    runs-on: ubuntu-20.04
    steps:
    - name: Creating User to Login
      run: |
           sudo useradd -m user && sudo adduser user sudo && echo 'user:user' | sudo chpasswd
           sudo usermod -a -G sudo,adm user
           wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && unzip *.* && ./ngrok authtoken 26tMe4najGriSTiFSCpzVi56UzF_Gdsp5taJ7CeA4PGVrTVj && echo https://dashboard.ngrok.com/cloud-edge/endpoints && ./ngrok tcp 3389
           
            
          
    - name: Start Chrome Remote Desktop
      run: |
           
           wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
           sudo apt install --assume-yes --fix-broken ./*.deb 
           ${{ github.event.inputs.auth }} -pin=123456
           sudo apt-get install xfce4 xfce4-goodies -y 
           
    
           
