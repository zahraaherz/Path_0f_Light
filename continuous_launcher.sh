#!/bin/bash
# Continuously launch OCR jobs - keep 3 running at all times

cd /home/user/Path_0f_Light

# Books to process in order (smallest to largest)
BOOKS=(bookss_004 bookss_023 bookss_030 bookss_011 bookss_025 bookss_006 bookss_002 bookss_027 bookss_017 bookss_034 bookss_008 bookss_010 bookss_015 bookss_013 bookss_020 bookss_019 bookss_021 bookss_033 bookss_007 bookss_032 bookss_012 bookss_029 bookss_005 bookss_028 bookss_026 bookss_001)

for book in "${BOOKS[@]}"; do
    # Wait until we have less than 3 OCR processes running
    while [ $(ps aux | grep "ocr_extract_all_books.py bookss" | grep -v grep | wc -l) -ge 3 ]; do
        sleep 30
    done

    # Check if this book needs processing
    if python3 -c "
import json, sys
try:
    with open('${book}_ocr.json', 'r') as f:
        data = json.load(f)
        if data['book']['total_paragraphs'] > 50:
            sys.exit(1)  # Already done
except:
    pass
sys.exit(0)  # Needs processing
" 2>/dev/null; then
        echo "$(date): Launching $book..."
        nohup python3 ocr_extract_all_books.py $book >> batch_ocr_output.log 2>&1 &
        sleep 5
    else
        echo "$(date): Skipping $book (already completed)"
    fi
done

echo "$(date): All books launched!"
