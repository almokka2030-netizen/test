# خطوات التشغيل - مشروع AI Brand Visibility Tester

## 📋 المتطلبات الأساسية

### 1. **حساب Cloudflare**
- تسجيل حساب على [Cloudflare](https://dash.cloudflare.com/sign-up)
- تفعيل Unified Billing للنماذج الخارجية (OpenAI, Anthropic, Google)

### 2. **Node.js**
- تثبيت Node.js الإصدار 22 أو أحدث
- التحقق من التثبيت:
```bash
node --version
npm --version
```

### 3. **Wrangler CLI** (سيتم تثبيته تلقائياً)
- أداة Cloudflare Workers

---

## 🚀 خطوات التشغيل

### الخطوة 1️⃣ : استنساخ المشروع
```bash
git clone https://github.com/almokka2030-netizen/test.git
cd test
```

### الخطوة 2️⃣ : تثبيت المكتبات
```bash
npm install
```
هذا سيثبت جميع المتطلبات:
- React 19.2.1
- React Router 7.9.6
- Hono 4.11.1
- Tailwind CSS 4.1.17
- TypeScript 5.9.3

### الخطوة 3️⃣ : تسجيل الدخول إلى Cloudflare
```bash
npx wrangler login
```
سيفتح متصفح لتسجيل الدخول وإعطاء صلاحيات

### الخطوة 4️⃣ : إنشاء KV Namespace
```bash
npx wrangler kv namespace create AEO_KV
```
ستحصل على معرّف (ID)، احفظه لاستخدامه لاحقاً في `wrangler.jsonc`

### الخطوة 5️⃣ : إنشاء Queue
```bash
npx wrangler queues create brand-visibility-jobs
```
هذا ينشئ طابور المعالجة المتوازية

### الخطوة 6️⃣ : تحديث ملف الإعدادات
**تحديث `wrangler.jsonc`:**
```jsonc
{
  "name": "test",
  "compatibility_date": "2025-01-16",
  
  // ⚠️ استبدل هذا المعرّف بالذي حصلت عليه من الخطوة 4
  "kv_namespaces": [
    { "binding": "AEO_KV", "id": "YOUR_NAMESPACE_ID_HERE" }
  ],
  
  "queues": {
    "producers": [
      { "binding": "QUEUE", "queue": "brand-visibility-jobs" }
    ],
    "consumers": [
      { "queue": "brand-visibility-jobs" }
    ]
  }
}
```

### الخطوة 7️⃣ : إضافة مفاتيح API (اختياري للتطوير)
**في ملف `.env.local`:**
```env
# نماذج بيانات (اختياري - Cloudflare يديرها تلقائياً عبر AI Gateway)
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=...
GOOGLE_API_KEY=...
```

---

## 💻 وضع التطوير

### البدء بخادم التطوير المحلي:
```bash
npm run dev
```
الخادم سيعمل على: **http://localhost:5173**

✨ **ميزات وضع التطوير:**
- Hot reload فوري عند تعديل الملفات
- Debugging سهل
- اختبار الواجهة محلياً قبل النشر

---

## 🏗️ البناء والنشر

### بناء المشروع:
```bash
npm run build
```
ينتج عنه:
- ملفات React مُحسّنة
- ملفات TypeScript مُترجمة
- أصول CSS محسّنة

### نشر على Cloudflare:
```bash
npm run deploy
```
**ماذا يحدث:**
1. بناء المشروع تلقائياً
2. نشر على Cloudflare Workers
3. تفعيل KV و Queues
4. تجهيز قاعدة البيانات

---

## 🔍 التحقق من التثبيت الناجح

بعد النشر، ستحصل على رابط مثل:
```
https://test.YOUR_SUBDOMAIN.workers.dev
```

### اختبر التطبيق:
1. افتح الرابط في المتصفح
2. أضف موقع ويب جديد
3. أدخل الكلمات المفتاحية
4. اختر النماذج المراد اختبارها
5. اضغط "ابدأ الاختبار"

---

## ⚙️ خطوات التشغيل المتقدمة

### استخدام 50 الخصائص الإدارية المتقدمة:

#### 1. استيراد PropertyManager:
```typescript
import PropertyManager, { ADVANCED_PROPERTIES } from '@/config/advancedProperties';

// تهيئة النظام
PropertyManager.initialize();
```

#### 2. تفعيل الخصائص:
```typescript
// تفعيل لوحة التحكم الإدارية
PropertyManager.enableProperty('admin_dashboard_enabled');

// تفعيل المراقبة الفورية
PropertyManager.enableProperty('real_time_alerts');

// تفعيل تحسين التكاليف
PropertyManager.enableProperty('cost_optimization');
```

#### 3. الحصول على إعدادات فئة معينة:
```typescript
// الحصول على جميع خصائص الأمان
const securityProps = PropertyManager.getPropertiesByCategory('security');

// الحصول على جميع خصائص تحليلات البيانات
const analyticsProps = PropertyManager.getPropertiesByCategory('analytics');
```

#### 4. تصدير/استيراد الإعدادات:
```typescript
// تصدير جميع الإعدادات الحالية
const config = PropertyManager.exportConfiguration();
localStorage.setItem('system-config', JSON.stringify(config));

// استيراد الإعدادات المحفوظة
const savedConfig = JSON.parse(localStorage.getItem('system-config'));
PropertyManager.importConfiguration(savedConfig);
```

#### 5. إضفاء تتبع الأداء:
```typescript
// تفعيل مراقبة صحة النظام
PropertyManager.enableProperty('system_health_monitoring');

// تفعيل تحليلات الأداء
PropertyManager.enableProperty('model_performance_tracking');
```

---

## 🛡️ الأمان والإعدادات الموصى بها

### تفعيل الخصائص الأمنية:
```typescript
// تفعيل جميع خصائص الأمان
const securityProps = [
  'encryption_at_rest',
  'tls_enforcement',
  'rate_limiting',
  'ddos_protection',
  'oauth2_integration'
];

securityProps.forEach(prop => PropertyManager.enableProperty(prop));
```

### إعدادات الأداء:
```typescript
// تفعيل تحسينات الأداء
PropertyManager.enableProperty('cdn_acceleration');
PropertyManager.enableProperty('query_optimization');
PropertyManager.enableProperty('lazy_loading');
PropertyManager.enableProperty('batch_processing');
```

---

## 📊 استخدام تحليلات البيانات

### تفعيل التحليلات المتقدمة:
```typescript
// تفعيل جميع التحليلات
PropertyManager.enableProperty('brand_visibility_analytics');
PropertyManager.enableProperty('custom_dashboards');
PropertyManager.enableProperty('real_time_alerts');
PropertyManager.enableProperty('sentiment_analysis');
PropertyManager.enableProperty('scheduled_reports');

// تصدير التقارير
const reports = PropertyManager.getProperty('export_functionality');
console.log('تنسيقات التصدير المتاحة:', reports.value);
```

---

## 🔧 استكشاف الأخطاء

### مشكلة: خطأ في الاتصال بـ Cloudflare
```bash
# حل: أعد تسجيل الدخول
npx wrangler logout
npx wrangler login
```

### مشكلة: KV Namespace غير معروف
```bash
# حل: تحقق من المعرّف في wrangler.jsonc
npx wrangler kv namespace list
```

### مشكلة: الخادم لا يستجيب
```bash
# حل: امسح الكاش وأعد التثبيت
rm -rf node_modules package-lock.json
npm install
npm run dev
```

### مشكلة: خطأ في TypeScript
```bash
# حل: تحديث أنواع البيانات
npm run cf-typegen
npm run typecheck
```

---

## 📚 الملفات المهمة

```
test/
├── wrangler.jsonc          # إعدادات Cloudflare Workers
├── package.json            # مكتبات المشروع
├── tsconfig.json           # إعدادات TypeScript
├── src/
│   ├── config/
│   │   └── advancedProperties.ts  # ✨ 50 الخصائص الإدارية المتقدمة
│   ├── app.tsx             # تطبيق React
│   └── ...
├── workers/
│   ├── app.ts              # نقطة دخول Cloudflare
│   ├── api.ts              # مسارات API
│   └── queue.ts            # معالج الطابور
└── README.md
```

---

## 🎯 الخطوات النهائية

### 1. اختبر الميزات المتقدمة:
```bash
# شغل خادم التطوير
npm run dev

# افتح المتصفح على http://localhost:5173
# ستجد:
# - لوحة التحكم الإدارية
# - الرسوم البيانية التحليلية
# - تتبع الأداء الفوري
```

### 2. نشّر على الإنتاج:
```bash
npm run deploy
```

### 3. راقب الأداء:
```bash
# عبر Cloudflare Dashboard
# https://dash.cloudflare.com → Workers → تطبيقك
```

---

## 📞 المساعدة والموارد

- 📖 [توثيق Cloudflare Workers](https://developers.cloudflare.com/workers/)
- 🤖 [توثيق AI Gateway](https://developers.cloudflare.com/ai-gateway/)
- 🔑 [إدارة مفاتيح API](https://developers.cloudflare.com/ai-gateway/keys/)
- 💰 [سعر Unified Billing](https://developers.cloudflare.com/ai-gateway/features/unified-billing/)

---

**✅ تم! مشروعك جاهز للعمل بالكامل!**

الآن يمكنك:
- 🧪 اختبار النماذج الـ 5
- 📊 تحليل ظهور علامتك التجارية
- ⚡ الاستفادة من 50 خاصية إدارية متقدمة
- 🚀 نشر بسرعة على Cloudflare

