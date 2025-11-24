# used to Make sure that the state is ready to go

FILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $FILE_DIR/../scripts/stow-helpers.sh

## First check that we have the zen browser installed!

if ! program_exists zen; then
  echo "Need to have the zen browser! please install it first"
  exit 1
fi


