## install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

## install docker
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

##nividia container toolkit
sudo apt-get update \
    && sudo apt-get install -y nvidia-container-toolkit-base
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

git clone https://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@github.com/hukuki/haystack.git
aws configure
cd haystack

## if using the boot disk
mkdir opensearch-data
cd opensearch-data

aws s3 sync s3://haystack-opensearch-data .
cd ..

sudo OPENSEARCH_VOLUME_PATH="/mnt/vol_b/opensearch-data" docker compose -f docker-compose-open-search-dbert-1.yml up -d
