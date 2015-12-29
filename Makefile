docker-image:
	rm -f hackage-downloads
	curl http://haskellbr.com.s3-website-sa-east-1.amazonaws.com/hackage-downloads/hackage-downloads.bz2 > hackage-downloads.bz2
	curl http://haskellbr.com.s3-website-sa-east-1.amazonaws.com/hackage-downloads/hackage-downloads-api.bz2 > hackage-downloads-api.bz2
	bzip2 -d hackage-downloads.bz2
	bzip2 -d hackage-downloads-api.bz2
	chmod +x hackage-downloads
	chmod +x hackage-downloads-api
	docker build -t haskellbr/hackage-downloads:`git rev-parse HEAD` .
	docker tag -f haskellbr/hackage-downloads:`git rev-parse HEAD` haskellbr/hackage-downloads:latest

docker-push-image:
	docker push haskellbr/hackage-downloads:`git rev-parse HEAD`
	docker push haskellbr/hackage-downloads:latest
