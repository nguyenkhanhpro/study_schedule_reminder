# SRS — Quản lí học tập và nhắc nhở

**Hệ thống**: Quản lí học tập và nhắc nhở ABC  
**Phiên bản**: 1.0  
**Ngôn ngữ giao diện**: Tiếng Việt (mặc định), English  
**Công nghệ**: Flutter mobile

| Thông tin tài liệu | |
|---|---|
| **Tác giả** | Nguyễn Văn B — Business Analyst (BA) |
| **Ngày tạo** | 17/04/2026 |
| **Dựa trên** | [BRD v1.0](BRD.md) — Yêu cầu nghiệp vụ từ khách hàng (16/04/2026) |
| **Trạng thái** | Đã duyệt bởi các bên liên quan |
---

## 1. Tổng quan hệ thống

Hệ thống quản lý lịch học cá nhân và nhắc nhở dành cho người học. Ứng dụng hỗ trợ người dùng tạo, quản lý và theo dõi lịch học theo ngày, đồng thời cung cấp thông báo trước giờ học.

| Vai trò | Quyền hạn |
|---------|----------|
| **Người dùng (User)** | Đăng nhập, quản lý lịch học cá nhân, xem lịch hôm nay, nhận nhắc nhở |

---

### Đặc điểm kỹ thuật

- Ứng dụng hoạt động **offline-first** (không cần internet)
- Dữ liệu được lưu trữ **cục bộ trên thiết bị (SQLite)**
- Notification hoạt động bằng **local notification**
- Mỗi người dùng có **dữ liệu riêng biệt**
- Thời gian hệ thống lấy từ **thiết bị (device time)**

---

## 2. Danh sách yêu cầu

---

### REQ-01: Đăng nhập / Login

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Người dùng đăng nhập vào hệ thống |
| **Input** | Email, mật khẩu |
| **Quy tắc** | Email hợp lệ + mật khẩu đúng → đăng nhập thành công |
| **Thông báo lỗi** | "Sai email hoặc mật khẩu", "Vui lòng nhập đầy đủ thông tin" |
| **Sau đăng nhập** | Hiển thị tên người dùng trên màn hình chính |

---

### REQ-02: Xem lịch hôm nay / View Today Schedule

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Hiển thị danh sách lịch học trong ngày hiện tại |
| **Dữ liệu hiển thị** | Môn học, thời gian, ghi chú |
| **Quy tắc** | Lọc theo `day_of_week = hôm nay` |
| **Sắp xếp** | Theo thời gian tăng dần |
| **Không có dữ liệu** | Hiển thị "Hôm nay không có lịch học" |

---

### REQ-03: Thêm lịch học / Add Schedule

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Người dùng tạo lịch học mới |
| **Input** | Tên môn, ngày trong tuần, giờ, ghi chú |
| **Quy tắc** | Không để trống môn học và thời gian |
| **Kết quả** | Lưu vào database và hiển thị ngay |

---

### REQ-04: Sửa và xóa lịch học / Update & Delete Schedule

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Cho phép chỉnh sửa hoặc xóa lịch học |
| **Quy tắc** | Chỉ thao tác trên dữ liệu của chính người dùng |
| **Kết quả** | Dữ liệu được cập nhật ngay lập tức |

---

### REQ-05: Nhắc nhở / Notification

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Gửi thông báo trước giờ học |
| **Thời gian** | Trước giờ học 10–15 phút |
| **Cơ chế** | Local notification |
| **Nội dung** | "Sắp đến giờ học [Tên môn]" |
| **Yêu cầu** | Phải xin quyền notification từ thiết bị |

---

### REQ-06: Tìm kiếm lịch học / Search Schedule

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Tìm kiếm lịch theo tên môn học |
| **Quy tắc** | Không phân biệt hoa/thường |
| **Không có kết quả** | Hiển thị "Không tìm thấy" |

---

### REQ-07: Lưu trữ dữ liệu / Data Persistence

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Lưu dữ liệu lịch học |
| **Công nghệ** | SQLite |
| **Yêu cầu** | Dữ liệu không mất khi tắt app |

---

### REQ-08: Quản lý tài khoản / Account Management

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Quản lý thông tin người dùng |
| **Xác thực email** | Email phải đúng định dạng `user@domain.ext` |
| **Bảo mật** | Không hiển thị thông tin người khác |

---

## 3. Yêu cầu phi chức năng

| Mã | Yêu cầu |
|----|--------|
| NFR-01 | Ứng dụng phản hồi < 2 giây |
| NFR-02 | Giao diện dễ sử dụng |
| NFR-03 | Hoạt động offline |
| NFR-04 | Tương thích Android phổ biến |
| NFR-05 | Notification hoạt động ổn định |

---

## 4. Mô hình dữ liệu

```json
Schedule {
  id: string,
  subject: string,
  day_of_week: int,
  time: string,
  note: string
}
```

## 5. Dữ liệu ban đầu / Seed Data

### 5.1. Tài khoản / Accounts

| Email | Mật khẩu | Vai trò | ID |
|-------|----------|---------|-----|
| `user1@email.com` | `123456` | Người dùng | USER001 |
| `user2@email.com` | `123456` | Người dùng | USER002 |

---

### 5.2. Lịch học / Schedules

| ID | Môn học | Thứ | Thời gian | Ghi chú |
|----|--------|-----|-----------|--------|
| SCH001 | Lập trình Flutter | 1 | 07:00 | Học trên lớp |
| SCH002 | Cơ sở dữ liệu | 1 | 13:00 | Lab |
| SCH003 | Trí tuệ nhân tạo | 2 | 09:00 | Online |
| SCH004 | Hệ điều hành | 3 | 08:00 | Phòng A1 |
| SCH005 | Mạng máy tính | 4 | 10:00 | Thực hành |

---

### 5.3. Tham số hệ thống / System Parameters

| Tham số | Giá trị |
|---------|---------|
| Thời gian nhắc mặc định | **10 phút trước giờ học** |
| Ngày trong tuần | **1–7 (Thứ 2 → Chủ nhật)** |
| Định dạng thời gian | **HH:mm** |

---

## 6. Giao diện hệ thống / System Interface

### 6.1. Màn hình chính (sau đăng nhập)

| Tab | Mô tả |
|-----|------|
| **Hôm nay** | Hiển thị lịch học trong ngày |
| **Lịch học** | Danh sách tất cả lịch học |
| **Thêm** | Thêm lịch học mới |

---

### 6.2. Màn hình chức năng

| Màn hình | Mô tả |
|----------|------|
| Login | Đăng nhập người dùng |
| Home | Hiển thị lịch hôm nay |
| Add Schedule | Thêm lịch học |
| Edit Schedule | Sửa lịch học |
| Search | Tìm kiếm lịch học |

---

## 7. Ràng buộc kỹ thuật / Technical Constraints

1. **Offline-first** — Ứng dụng hoạt động không cần internet.
2. **Local database** — Sử dụng SQLite để lưu trữ dữ liệu.
3. **Local notification** — Sử dụng `flutter_local_notifications`.
4. **Single user** — Dữ liệu không chia sẻ giữa các user.
5. **Platform** — Android (ưu tiên), iOS (optional).
6. **Time-based logic** — Phụ thuộc vào thời gian thiết bị.

---

## 8. Thiết kế dữ liệu / Data Design

### 8.1. Bảng Schedule

```sql
CREATE TABLE schedules (
  id TEXT PRIMARY KEY,
  subject TEXT NOT NULL,
  day_of_week INTEGER NOT NULL,
  time TEXT NOT NULL,
  note TEXT
);
```

### 8.2. Bảng User
```sql
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  email TEXT UNIQUE,
  password TEXT
);
```

## 9. Luồng xử lý chính

### 9.1. Hiển thị lịch hôm nay

- Lấy ngày hiện tại từ hệ thống:
  - `current_day = DateTime.now().weekday`
- Truy vấn dữ liệu:
  - Lọc danh sách lịch theo `day_of_week = current_day`
- Sắp xếp:
  - Theo thời gian tăng dần (`ASC`)
- Hiển thị:
  - Danh sách môn học trong ngày

---

### 9.2. Thêm lịch học

- Người dùng nhập:
  - Tên môn
  - Thứ
  - Thời gian
  - Ghi chú
- Validate:
  - Không được để trống
  - Định dạng thời gian hợp lệ
- Lưu vào SQLite
- Cập nhật UI ngay lập tức

---

### 9.3. Notification

- Khi tạo lịch:
  - Parse thời gian → DateTime
  - Trừ thời gian nhắc (10–15 phút)
  - Schedule notification
- Nội dung:
  - "Sắp đến giờ học [Tên môn]"

---

### 9.4. CRUD Schedule

- Create → Insert DB
- Read → Query list
- Update → Update theo ID
- Delete → Delete theo ID

---

## 10. Xử lý lỗi

| Trường hợp | Xử lý |
|-----------|------|
| Không nhập môn học | Hiển thị thông báo lỗi |
| Sai định dạng thời gian | Không cho phép submit |
| Notification bị tắt | Yêu cầu cấp quyền |
| Lỗi database | Hiển thị thông báo |
| Không có dữ liệu | Hiển thị "Không có lịch học" |

---

## 11. Bảo mật

- Không chia sẻ dữ liệu giữa người dùng
- Dữ liệu lưu cục bộ trên thiết bị
- Mật khẩu nên được mã hóa (hash) (nâng cao)
- Không expose dữ liệu ra ngoài hệ thống
- Kiểm soát quyền truy cập dữ liệu theo user

---

## 12. Hướng mở rộng

- Đồng bộ dữ liệu với Firebase
- Đăng nhập bằng Google / Facebook
- Thêm giao diện lịch (Calendar view)
- Thống kê thời gian học
- Nhắc nhở thông minh (AI)
- Đồng bộ nhiều thiết bị