#!/bin/bash
VERSION=$(date +%Y%m%d%H%M%S) # 以時間戳作為版本號
INDEX_FILE="build/web/index.html"

# 替換 flutter_bootstrap.js 版本號
sed -i '' "s|flutter_bootstrap\.js.*\"|flutter_bootstrap.js?version=$VERSION\"|g" "$INDEX_FILE"

echo "✅ 已更新版本號為 $VERSION"
