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

# Send tokenization request to VGS API
# Example usage:
# ./tokenize.sh "98761234019273877823782302238889920029:card_number" \
#               "Joe Business:card_name" \
#               "12/24:expiration_date" \
#               "123:cvc" 
#
# The list of all possible token classifiers can be found here:
# https://docs.verygoodsecurity.com/docs/classifiers

# We will use the following tolken classifiers in this test script:
# card_number, card_name, expiration_date, cvc

# NOTE: Token Alias Format is set to UUID in this test script.
#     This means that the token will be a UUID string.
#     If you want to use a different format, change the "format" field in env variable below.
export VGS_TOKEN_ALIAS_FORMAT="UUID" 
# For other formats, you can reference the VGS documentation:
# https://www.verygoodsecurity.com/docs/vault/concepts/tokens#alias-formats


# NOTE: Make sure not to disable fingerprinting feature in the VGS API
#       as it is required for tokenization test to return the same token
#       for the same value and classifier.
# see: https://www.verygoodsecurity.com/docs/vault/concepts/tokens#fingerprinting


./tokenize.sh "98761234019273877823782302238889920029:card_number" \
              "Joe Business:card_name" \
              "12/24:expiration_date" \
              "123:cvc"

