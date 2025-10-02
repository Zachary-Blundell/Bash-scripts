#!/bin/bash
#     ____        _ __         _   __      __          __  ___      __
#    / __ \____ _(_) /_  __   / | / /___  / /____     /  |/  /___ _/ /_____  _____
#   / / / / __ `/ / / / / /  /  |/ / __ \/ __/ _ \   / /|_/ / __ `/ //_/ _ \/ ___/
#  / /_/ / /_/ / / / /_/ /  / /|  / /_/ / /_/  __/  / /  / / /_/ / ,< /  __/ /
# /_____/\__,_/_/_/\__, /  /_/ |_/\____/\__/\___/  /_/  /_/\__,_/_/|_|\___/_/
#                 /____/
# Author : Zachary Blundell
# This script is used to create a daily Markdown note inside a log folder
# intended to be run locally

set -eo pipefail

# Root of log hierarchy
notes_root="$HOME/Nextcloud/Notes/log"

# Verify that the root directory exists
if [[ ! -d "${notes_root}" ]]; then
  echo "Error: notes folder '${notes_root}' is missing" >&2
  exit 1
fi
# ---------------------------------------------------------------------------
# Fetch an inspirational quote (prefer QuoteSlate, fall back to ZenQuotes)
# ---------------------------------------------------------------------------

get_quote() {
  # 1️⃣  Try the QuoteSlate API
  # https://quoteslate.vercel.app/
  if json=$(curl -fsSL "https://quoteslate.vercel.app/api/quotes/random?count=1"); then
    quote=$(echo "$json" | jq -r '.[0].quote')
    author=$(echo "$json" | jq -r '.[0].author')

    echo "$quote"
    echo "$author"
    exit 1
    # quote2=$(echo "$json" | jq -r '.[1].quote')
    # author2=$(echo "$json" | jq -r '.[1].author')
  fi

  # 2️⃣  Fallback: ZenQuotes (no tag filter, but good general corpus)
  if [[ -z "$quote" || "$quote" == "null" ]]; then
    if json=$(curl -fsSL "https://zenquotes.io/api/random"); then
      quote=$(echo "$json" | jq -r '.[0].q')
      author=$(echo "$json" | jq -r '.[0].a')
    fi
  fi

  # 3️⃣  If everything failed, return a placeholder
  if [[ -z "$quote" || "$quote" == "null" ]]; then
    quote="Could not fetch an inspirational quote today."
    author=""
  fi

}
# --------------------------------------------------------------------
# Date components
# --------------------------------------------------------------------
day_num="$(date +'%d')"
day_name_short="$(date +'%a')" # locale's abbreviated weekday name (e.g., Sun)
day_name_long="$(date +'%A')"  # locale's full weekday name (e.g., Sunday)

day_of_year="$(date +'%j')"  # day of year (001..366)
week_of_year="$(date +'%U')" # week number of year, with Sunday as first day of week (00..53)

month_num="$(date +'%m')"        # 01‑12 (two‑digit, leading zero)
month_name_short="$(date +'%b')" # locale's abbreviated month name (e.g., Jan)
month_name_long="$(date +'%B')"  # locale's full month name (e.g., January)

year="$(date +'%Y')" # four‑digit year

# Target directory: ~/Nextcloud/Notes/<YEAR>/<MONTH>(<MONTHNAME>)
# mkdir -p is idempotent: it creates the directory tree only if missing
notes_dir="${notes_root}/${year}/${month_num}(${month_name_short})"
mkdir -p "${notes_dir}"

# Target filename: <DAY>(<DAYNAME>)-<MONTH>-<YEAR>.md
file_name="${day_num}(${day_name_short})-${month_num}-${year}.md"
file_path="${notes_dir}/${file_name}"

# Abort if the note already exists (prevent accidental overwrite)
if [[ -e "${file_path}" ]]; then
  echo "Error: File '${file_path}' already exists." >&2
  exit 1
fi

# Get the quote(s) if everything else worked
get_quote

# Create the note with a simple title header; feel free to customize
{
  echo " # $day_name_long $day_num / $month_name_long $month_num / $year
  **Day: $day_of_year Week: $week_of_year**
  > \"$quote\" — *$author*

  ## Top 3 Priorities
  - [ ] X
  - [ ] Y
  - [ ] Z

  ## Notes & Ideas


  "
} >"${file_path}"

# Confirmation
echo "Markdown file created: ${file_path}"
