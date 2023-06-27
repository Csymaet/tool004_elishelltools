#!/bin/bash
# Credit: https://christiantietze.de/posts/2017/05/sort-markdown-tables-shell/
# For example: ./6.sort_markdown_table.sh ./files/book_list.md 2

(head -n 2 $1 && tail -n +3 $1 | sort -t '|' -k $2)
