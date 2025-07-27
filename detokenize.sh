# detokenize.sh
# by Mario De Armas
# 2025

# Example script usage:
# ./detokenize.sh tok_sandbox_eEhvAbg5dkgu2wuzqeCmq6,tok_sandbox_k4FQhNkLDikwgfrYWrFqbu

# VGS detokinizer API:
# curl https://api.sandbox.verygoodvault.com/aliases\?q=tok_sandbox_eEhvAbg5dkgu2wuzqeCmq6,tok_sandbox_k4FQhNkLDikwgfrYWrFqbu,tok_sandbox_6deimuQsShyRd4EmCXfx1Y,tok_sandbox_tp7DQVCDCVLaPVawjrQn6D \
#  -u $USERID:$PASSWORD \
#  -H 'Content-Type: application/json' \
#  -s


echo "Very Good Security (VGS) Detokenizer"

# Ensure VGS_USERID and VGS_PASSWORD are set
if [ -z "$VGS_USERID" ] || [ -z "$VGS_PASSWORD" ]; then
  echo "Error: VGS_USERID and VGS_PASSWORD environment variables must be set."
  exit 0
fi  

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 token1,token2,..."
  exit 0
fi
 
# Build comma-separated list of tokens from command line arguments
tokens=$(IFS=, ; echo "$*")

# Make GET request to VGS API
response=$(curl "https://api.sandbox.verygoodvault.com/aliases?q=${tokens}" \
  -u "$VGS_USERID:$VGS_PASSWORD" \
  -H 'Content-Type: application/json' \
  -s)
  #-v)      # Uncomment for verbose output

if [ $? -ne 0 ]; then
  echo "Error: Failed to fetch values from tokens."
  exit 0
fi  

echo "Response from API:"
echo "$response" | jq .
printf '%.0s-' {1..100}; echo
printf "%-40s | %-20s | %s\n" "Token (Alias)" "Classifier" "Value"
printf '%.0s-' {1..100}; echo
# Extract token, classifiers, and value from response using jq
echo "$response" | jq -r '.data[] | "\(.aliases[0].alias):\(.classifiers[0]):\(.value)"' | while IFS=: read token classifier value; do
  printf "%-40s | %-20s | %s\n" "$token" "$classifier" "$value"
done    

echo "\n"
echo "detokenization completed successfully."
exit 0