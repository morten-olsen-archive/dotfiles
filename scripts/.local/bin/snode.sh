IMAGE="${DOCKER_IMAGE:-node:latest}"
ROOT="$PWD"
CWD="$PWD"
ARGS="--rm -i"

if git rev-parse --show-toplevel &> /dev/null; then
  ROOT=`git rev-parse --show-toplevel`
fi

if [ -t 1 ]; then
  ARGS="$ARGS -t"
fi  

docker \
  --context default \
  run \
  $ARGS \
  -e NPM_GITLAB_TOKEN="$NPM_GITLAB_TOKEN" \
  --net=host \
  --user "$UID:$GID" \
  -v "$ROOT:$ROOT" \
  --workdir="$CWD" \
  "$IMAGE" \
  $@
