#!/bin/bash
# 清理 LaTeX 编译产生的辅助文件
# 用法: bash clean.sh

cd "$(dirname "$0")"

rm -f main.aux main.bbl main.blg main.bcf \
      main.fdb_latexmk main.fls \
      main.lof main.log main.lot \
      main.out main.run.xml \
      main.synctex.gz main.toc main.xdv

echo "编译文件已清理"
