# This script was created by Chat GPT :)

#!/bin/bash

# === Configuration ===
BASE_URL="http://change-to-targeted-url"
PATHS=("/get" "/post")
DELAYS=(0.25 0.5 1 2 3 5)

IP_LIST=(23.14.89.201 34.110.174.22 44.192.48.12 45.33.32.156 52.15.72.219
54.241.24.25 62.210.130.250 63.142.250.198 64.233.191.255 66.165.240.10
67.207.89.15 68.183.44.42 69.89.31.226 70.32.96.100 71.19.248.50
72.14.178.20 74.125.136.113 75.101.213.120 76.76.21.21 77.68.64.12
78.47.56.180 80.69.173.10 81.169.145.149 82.94.234.10 84.38.184.130
85.214.132.117 86.105.235.123 87.106.178.203 88.198.39.205 91.189.91.157
92.205.9.106 93.184.216.34 94.130.50.206 95.216.24.32 96.45.83.181
97.107.133.177 98.137.11.163 99.84.238.176 100.24.208.97 101.32.99.13
102.165.48.33 103.21.244.0 104.26.3.2 105.112.32.17 107.170.221.10
108.61.10.10 109.74.202.18 110.93.148.73 111.90.143.210 112.78.3.162)

USER_AGENTS=(
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"
"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Safari/605.1.15"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:116.0) Gecko/20100101 Firefox/116.0"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36 OPR/91.0.4516.75"
"curl/7.85.0"
"PostmanRuntime/7.32.0"
)

# === Function for a single worker ===
traffic_worker() {
  local END_TIME=$(( $(date +%s) + 3600 ))  # Run 1 hour

  while [ $(date +%s) -lt $END_TIME ]; do
    path=${PATHS[$((RANDOM % ${#PATHS[@]}))]}
    ip=${IP_LIST[$((RANDOM % ${#IP_LIST[@]}))]}
    ua=${USER_AGENTS[$((RANDOM % ${#USER_AGENTS[@]}))]}
    url="${BASE_URL}${path}"

    echo "[$(date '+%T')] $path  | IP: $ip  | UA: $(echo "$ua" | cut -d' ' -f1)"

    if [ "$path" == "/get" ]; then
      curl -s -X GET "$url" \
        -H "X-Forwarded-For: $ip" \
        -H "User-Agent: $ua" \
        -o /dev/null
    else
      curl -s -X POST "$url" -d '{}' \
        -H "Content-Type: application/json" \
        -H "X-Forwarded-For: $ip" \
        -H "User-Agent: $ua" \
        -o /dev/null
    fi

    delay=${DELAYS[$((RANDOM % ${#DELAYS[@]}))]}
    sleep "$delay"
  done
}

# === Launch 5 parallel workers ===
for i in {1..5}; do
  traffic_worker &
done

wait
echo "All workers completed after 1 hour."
