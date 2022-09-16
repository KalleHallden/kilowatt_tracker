#!/usr/bin/env bash

# Check for dependencies
if ! which jq > /dev/null; then
   echo -e "jq not found! Install? (y/n) \c"
   read -r
   if [ "$REPLY" = "y" ]; then
      sudo apt-get install jq
   else
      exit 1
   fi
fi

# Get date and time
today=$(date +%Y-%m-%d)
time=$(date +%H)

# API configuration
api_base_url="https://www.vattenfall.se/api"

# Postal code is used to get you price area
# Change to you postal code
postal_code="60123"

# You can hard code your price area to limit your request count to the API
# pricearea="SN1" # Norra Sverige
# pricearea="SN2" # Norra Mellan Sverige
# pricearea="SN3" # Södra Mellan Sverige
# pricearea="SN4" # Södra Sverige
pricearea=$(curl -s "${api_base_url}/priceareainfo/zipcode/${postal_code}" | jq -j .priceArea)

# Get todays kilowatt prices
response=$(curl -s "${api_base_url}/price/spot/pricearea/${today}/${today}/${pricearea}")
price=$(jq -j ".[${time##0}].Value" <<< "${response}")
unit=$(jq -j ".[${time##0}].Unit" <<< "${response}")

# Return current hour kilowatt price 
printf "%s %s\n" "${price}" "${unit}"
