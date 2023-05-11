# Read in the .env file and set environment variables
while read -r line || [[ -n "$line" ]]; do
  if [[ "$line" =~ ^[^#]*= ]]; then
    key="${line%=*}"
    value="${line#*=}"
    export "$key"="$value"
  fi
done < .env

echo "Environment variables all set..."