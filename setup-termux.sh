#!/bin/bash

# خطوات التشغيل السريعة لـ Termux

echo "🔧 بدء تثبيت المشروع..."

# الخطوة 1: تحديث npm
echo "📦 تحديث npm..."
npm install -g npm@latest

# الخطوة 2: تنظيف التثبيت السابق
echo "🧹 تنظيف التثبيتات القديمة..."
rm -rf node_modules
rm -f package-lock.json

# الخطوة 3: تثبيت المكتبات
echo "📥 تثبيت المكتبات (قد يستغرق دقائق)..."
npm install

# الخطوة 4: التحقق من التثبيت
echo "✅ التحقق من التثبيت..."
npm list react-router

# الخطوة 5: تصحيح الأنواع
echo "🔍 تصحيح أنواع TypeScript..."
npm run cf-typegen 2>/dev/null || echo "⚠️ تم تخطي cf-typegen"

# الخطوة 6: جاهز للتشغيل
echo ""
echo "✨ تم التثبيت بنجاح!"
echo ""
echo "🚀 لبدء التطوير، استخدم:"
echo "   npm run dev"
echo ""
echo "🏗️ للبناء والنشر:"
echo "   npm run build"
echo "   npm run deploy"
