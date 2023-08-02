gcloud compute instances create dre-docker-ppe-1 \
    --project=warp-372209 \
    --zone=us-central1-a \
    --machine-type=n2d-custom-8-16384 \
    --network-interface=network-tier=PREMIUM,subnet=default \
    --metadata=startup-script=\#\!/bin/bash\ \
-ex$'\n'exec\ \>\ \>\(tee\ /var/log/user-data.log\|logger\ -t\ user-data\ -s\ 2\>/dev/console\)\ 2\>\&1$'\n'echo\ BEGIN$'\n'sudo\ apt-get\ update$'\n'sudo\ apt-get\ install\ -y\ \\$'\n'\ \ \ \ ca-certificates\ \\$'\n'\ \ \ \ curl\ \\$'\n'\ \ \ \ wget\ \\$'\n'\ \ \ \ gnupg\ \\$'\n'\ \ \ \ lsb-release$'\n'sudo\ mkdir\ -p\ /etc/apt/keyrings$'\n'curl\ -fsSL\ https://download.docker.com/linux/debian/gpg\ \|\ sudo\ gpg\ \
    --dearmor\ \
-o\ /etc/apt/keyrings/docker.gpg$'\n'echo\ \\$'\n'\"deb\ \[arch=\$\(dpkg\ \
    --print-architecture\)\ \
signed-by=/etc/apt/keyrings/docker.gpg\]\ https://download.docker.com/linux/debian\ \\$'\n'\ \ \$\(lsb_release\ -cs\)\ stable\"\ \|\ sudo\ tee\ /etc/apt/sources.list.d/docker.list\ \>\ /dev/null$'\n'sudo\ apt-get\ update$'\n'sudo\ apt-get\ install\ -y\ docker-ce\ docker-ce-cli\ containerd.io\ docker-buildx-plugin\ docker-compose-plugin$'\n'$'\n'sudo\ useradd\ -g\ docker\ -s\ /bin/bash\ -m\ dre \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --service-account=890342139507-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --tags=http-server,https-server \
    --create-disk=auto-delete=yes,boot=yes,device-name=dre-docker-ppe,image=projects/debian-cloud/global/images/debian-11-bullseye-v20221206,mode=rw,size=120,type=projects/warp-372209/zones/us-central1-a/diskTypes/pd-ssd \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=ec-src=vm_add-gcloud \
    --reservation-affinity=any