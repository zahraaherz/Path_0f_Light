#!/bin/bash
# Continuous OCR monitoring and auto-commit script

cd /home/user/Path_0f_Light

while true; do
    # Check if batch process is running
    if ! pgrep -f "batch_ocr_all_books.py" > /dev/null; then
        echo "$(date): Starting batch OCR process..."
        nohup python3 batch_ocr_all_books.py > batch_ocr_output.log 2>&1 &
        sleep 10
    fi

    # Check for new completed books and commit
    if [ -f ocr_batch_progress.json ]; then
        # Check if there are uncommitted changes
        if ! git diff --quiet bookss_*_ocr.json 2>/dev/null; then
            echo "$(date): Committing completed books..."
            git add bookss_*_ocr.json ocr_batch_progress.json batch_ocr_output.log

            # Count completed books
            COMPLETED=$(python3 -c "
import json
count = 0
for i in range(1, 36):
    try:
        with open(f'bookss_{i:03d}_ocr.json', 'r') as f:
            data = json.load(f)
            if data['book']['total_paragraphs'] > 50:
                count += 1
    except: pass
print(count)
" 2>/dev/null)

            git commit -m "OCR progress checkpoint: ${COMPLETED}/35 books completed" 2>/dev/null
            git push 2>/dev/null
            echo "$(date): Pushed progress (${COMPLETED}/35 books)"
        fi
    fi

    # Wait 5 minutes before next check
    sleep 300
done
