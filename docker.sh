# https://github.com/envygeeks/jekyll-docker/blob/master/README.md

# cli: ./docker.sh jekyll [build,serve]
# cli: ./docker.sh bundle info

export JEKYLL_VERSION=4
docker run --rm \
  --volume="$PWD:/srv/jekyll" \
  --volume="/tmp/jekyll-ruby-bundle:/usr/local/bundle" \
  -p 4000:4000 \
  -it jekyll/jekyll:$JEKYLL_VERSION \
  $@

