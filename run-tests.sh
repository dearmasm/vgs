bash!

# Example values for tokenization
# Each value is a string in the format "value:classifier"
# Examples:
#   "98761234019273877823782302238889920029:card_number"
#   "Joe Business:card_name"
#   "12/24:expiration_date"
#   "123:cvc"

# Ensure USERID and PASSWORD are set
if [ -z "$USERID" ] || [ -z "$PASSWORD" ]; then
  echo "Error: USERID and PASSWORD environment variables must be set."
  exit 0
fi  

./tokenize.sh "98761234019273877823782302238889920029:card_number" \
              "Joe Business:card_name" \
              "12/24:expiration_date" \
              "123:cvc"

