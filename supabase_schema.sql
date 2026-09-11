-- ═════════════════════════════════════════════════════════════
-- SUPABASE SCHEMA CHO CRM BẤT ĐỘNG SẢN (XANH SM THEME)
-- Chạy script này trong SQL Editor của Supabase Project "CRM"
-- ═════════════════════════════════════════════════════════════

-- 1. Bảng Khách hàng Mua / Đầu tư
CREATE TABLE IF NOT EXISTS customers (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  zalo TEXT,
  source TEXT,
  purpose TEXT,
  prop_type TEXT,
  area TEXT,
  budget TEXT,
  area2 TEXT,
  status TEXT DEFAULT 'cold',
  personality TEXT,
  note TEXT,
  facebook TEXT,
  zalo_social TEXT,
  tiktok TEXT,
  instagram TEXT,
  youtube TEXT,
  created_at BIGINT,
  updated_at BIGINT
);

-- 2. Bảng Khách hàng Cho thuê
CREATE TABLE IF NOT EXISTS rentals (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  zalo TEXT,
  source TEXT,
  rental_type TEXT,
  area TEXT,
  price_min TEXT,
  price_max TEXT,
  size TEXT,
  duration TEXT,
  status TEXT DEFAULT 'cold',
  personality TEXT,
  note TEXT,
  created_at BIGINT,
  updated_at BIGINT
);

-- 3. Bảng Lịch sử cuộc gọi
CREATE TABLE IF NOT EXISTS call_logs (
  id TEXT PRIMARY KEY,
  customer_id TEXT NOT NULL,
  call_date TEXT,
  call_time TEXT,
  result TEXT,
  note TEXT,
  followup TEXT,
  reminder_date TEXT,
  reminder_time TEXT,
  reminder_note TEXT,
  done BOOLEAN DEFAULT FALSE,
  created_at BIGINT
);

-- 4. Bảng Nhắc hẹn
CREATE TABLE IF NOT EXISTS reminders (
  id TEXT PRIMARY KEY,
  customer_id TEXT NOT NULL,
  remind_date TEXT,
  remind_time TEXT,
  note TEXT,
  done BOOLEAN DEFAULT FALSE
);

-- Cho phép quyền truy cập qua Anon Key (public API)
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE rentals ENABLE ROW LEVEL SECURITY;
ALTER TABLE call_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE reminders ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow anon all on customers" ON customers FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon all on rentals" ON rentals FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon all on call_logs" ON call_logs FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon all on reminders" ON reminders FOR ALL USING (true) WITH CHECK (true);
