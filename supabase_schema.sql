-- ═════════════════════════════════════════════════════════════
-- SUPABASE SCHEMA NÂNG CẤP: ĐA TÀI KHOẢN (MULTI-ACCOUNT)
-- Hỗ trợ nhiều môi giới dùng chung app, dữ liệu tách biệt 100%
-- ═════════════════════════════════════════════════════════════

-- 1. Thêm cột user_id liên kết với tài khoản đăng nhập Supabase Auth
ALTER TABLE customers ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) DEFAULT auth.uid();
ALTER TABLE rentals ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) DEFAULT auth.uid();
ALTER TABLE call_logs ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) DEFAULT auth.uid();
ALTER TABLE reminders ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) DEFAULT auth.uid();

-- 2. Kích hoạt Row Level Security (RLS) bảo mật từng hàng
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE rentals ENABLE ROW LEVEL SECURITY;
ALTER TABLE call_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE reminders ENABLE ROW LEVEL SECURITY;

-- 3. Xóa các chính sách cũ (nếu có)
DROP POLICY IF EXISTS "Allow anon all on customers" ON customers;
DROP POLICY IF EXISTS "Allow anon all on rentals" ON rentals;
DROP POLICY IF EXISTS "Allow anon all on call_logs" ON call_logs;
DROP POLICY IF EXISTS "Allow anon all on reminders" ON reminders;
DROP POLICY IF EXISTS "Users can manage own customers" ON customers;
DROP POLICY IF EXISTS "Users can manage own rentals" ON rentals;
DROP POLICY IF EXISTS "Users can manage own call_logs" ON call_logs;
DROP POLICY IF EXISTS "Users can manage own reminders" ON reminders;

-- 4. Tạo chính sách bảo mật: Người dùng nào CHỈ ĐƯỢC xem/thêm/sửa/xóa dữ liệu của chính mình
CREATE POLICY "Users can manage own customers" ON customers
  FOR ALL TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can manage own rentals" ON rentals
  FOR ALL TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can manage own call_logs" ON call_logs
  FOR ALL TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can manage own reminders" ON reminders
  FOR ALL TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
