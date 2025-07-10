# HTTP Traffic Generator Scripts

[![GitHub issues](https://img.shields.io/github/issues/ahmadshaugi81/traffic-generator.svg)](https://github.com/ahmadshaugi81/traffic-generator/issues) 
[![GitHub license](https://img.shields.io/github/license/ahmadshaugi81/traffic-generator.svg)](https://github.com/ahmadshaugi81/traffic-generator/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/ahmadshaugi81/traffic-generator.svg)](https://github.com/ahmadshaugi81/traffic-generator/stargazers)

---

## Overview

This repository contains two bash scripts to generate HTTP traffic for testing purposes:

### 1. `traffic_generator.sh`

- Continuously sends HTTP GET and POST requests to specified paths (`/get` and `/post` respectively).  
- Randomizes delay between requests (0.25s to 5s).  
- Randomly picks `X-Forwarded-For` header from a list of public IPs (excluding Google DNS IPs).  
- Randomizes `User-Agent` header among popular browsers, curl, and Postman.  
- Useful for general HTTP load and basic header testing.

---

### 2. `owasp_sample_traffic.sh`

- Simulates 15 variations of common OWASP Top 10 attacks using HTTP GET requests.  
- Covers SQL Injection, Cross-site scripting (XSS), Command Injection, Path Traversal, and Prototype Pollution.  
- Adds spoofed `X-Forwarded-For` and randomized `User-Agent` headers.  
- Runs 5 parallel workers generating concurrent attack-like traffic.  
- Runs for 1 hour by default, ideal for security testing and detection validation.

---

## Usage

1. Clone or download this repository.

2. Make the scripts executable:

   ```bash
   chmod +x traffic_generator.sh
   chmod +x owasp_sample_traffic.sh
Run the scripts:
- For general HTTP traffic:

  ```bash
  ./traffic_generator.sh
- For OWASP attack simulation traffic:

  ```bash
  ./owasp_sample_traffic.sh

<br/> Example Output:

  ```bash
  [12:00:05] -> http://example.com/get
  [12:00:05] -> http://example.com/post
  [12:00:06] -> http://example.com/get
  [12:00:08] -> http://example.com/search?q=' OR '1'='1
  [12:00:08] -> http://example.com/comment?text=<script>alert('XSS')</script>
  ...
  All workers finished after 1 hour.
  ```
  
<br/> 


## Usage Customization

You can customize:

- BASE_URL in each script to target your own server
- IP addresses used in the X-Forwarded-For header list
- User-Agent strings
- Delay intervals between requests
- Number of parallel workers (in owasp_top5_traffic.sh)
- Add or modify payloads for OWASP tests
- Disclaimer

Use these scripts only on servers you own or have explicit permission to test. Unauthorized use is illegal and unethical.

---

## Author

**Scripts and README generated with assistance from ChatGPT (OpenAI GPT-4)**
**<br/> Maintained and documented by Ahmad Shaugi**

*Feel free to open issues or contribute improvements! :)*
