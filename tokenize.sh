# tokenize.sh
# by Mario De Armas
# 2025

# debugging
#set -x 

# This script tokenizes information using the Very Good Vault API
echo "Very Good Security (VGS) Tokenizer"

# Ensure USERID and PASSWORD are set
if [ -z "$USERID" ] || [ -z "$PASSWORD" ]; then
  echo "Error: USERID and PASSWORD environment variables must be set."
  exit 0
fi  

# Define the tokens to be sent to the API
# Each token is a string in the format "value:classifier"

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 value:classifier [value:classifier ...]"
  exit 0
fi

# Build the tokens array from command line arguments
tokenize_values=()
for arg in "$@"; do
  tokenize_values+=("$arg")
done

# Example of how the tokens array might look
# tokenize_values=(
#   "98761234019273877823782302238889920029:card_number"
#   "Joe Business:card_name"
#   "12/24:expiration_date"
#   "123:cvc"
# )


# Build JSON data from tokenize_values array
json_data='{"data":['
for item in "${tokenize_values[@]}"; do
  value="${item%%:*}"
  classifier="${item#*:}"
  json_data+='{"value":"'"$value"'","classifiers":["'"$classifier"'"],"format":"UUID"},'
done
# Remove trailing comma and close JSON array/object
json_data="${json_data%,}]}"


# Tokenize sensitive information using the Very Good Vault API
response=$(curl https://api.sandbox.verygoodvault.com/aliases \
  -X POST \
  -u "$USERID:$PASSWORD" \
  -H 'Content-Type: application/json' \
  -s \
  -d "$json_data")

# Check if the API call was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to tokenize data."
  exit 0
fi  

# Print the response from the API
echo "Response from API:"
echo "$response" | jq .
printf '%.0s-' {1..100}; echo
printf "%-40s | %-20s | %s\n" "Value" "Classifier" "Token (Alias)"
printf '%.0s-' {1..100}; echo
# Extract value, classifiers, and alias from response using jq
echo "$response" | jq -r '.data[] | "\(.value):\(.classifiers[0]):\(.aliases[0].alias)"' | while IFS=: read value classifier alias; do
  printf "%-40s | %-20s | %s\n" "$value" "$classifier" "$alias"
done

# Print success message
echo "Tokenization completed successfully."
exit 0  
# End of script
