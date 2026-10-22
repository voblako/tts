#!/usr/bin/env fish

set missing 0

# Find all .pptx files (excluding .git and node_modules directories)
for pptx in (find . -type f -name "*.pptx" -not -path "./.git/*" -not -path "./node_modules/*")
    set pdf (string replace '.pptx' '.pdf' $pptx)
    
    if not test -f $pdf
        echo "::warning::Нет PDF-дубля для: $pptx (ожидался: $pdf)"
        set missing 1
    end
end

if test $missing -ne 0
    echo "::error::Обнаружены .pptx файлы без .pdf дублей"
    exit 1
end

echo "Все .pptx файлы имеют PDF-дубль ✅"
