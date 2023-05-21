## install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


git clone https://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@github.com/hukuki/haystack.git
aws configure
cd haystack
mkdir opensearch-data
cd opensearch-data
aws s3 sync s3://haystack-opensearch-data .
cd ..
sudo docker compose -f docker-compose-open-search-dbert-1.yml up -d
