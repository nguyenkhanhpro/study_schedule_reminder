#  Study Reminder App — Quản lí học tập và nhắc nhở

## Giới thiệu

**Study Reminder App** là ứng dụng di động được xây dựng bằng **Flutter**, giúp người dùng quản lý lịch học cá nhân và nhận nhắc nhở trước giờ học.

Ứng dụng phù hợp với:
- Sinh viên
- Người tự học
- Người cần quản lý thời gian học tập

---

## Mục tiêu

- Quản lý lịch học theo ngày
- Hiển thị lịch học hôm nay
- Nhắc nhở trước giờ học
- Giao diện đơn giản, dễ sử dụng

---

## Demo giao diện (Figma)

Xem prototype tại đây:  
[Demo follow Figma](https://www.figma.com/proto/e8K2WQm8aVGxVODgmnoAfu/flutter-qu%E1%BA%A3n-l%C3%AD-h%E1%BB%8Dc-t%E1%BA%ADp?node-id=1-4&t=t5ZsB78SVtRv6ITG-1&scaling=scale-down&content-scaling=fixed&page-id=0%3A1)

---

## Tính năng chính

- Đăng nhập người dùng
- Xem lịch học hôm nay
- Thêm lịch học
- Tìm kiếm môn học
- Nhắc nhở trước giờ học

---

## Công nghệ sử dụng

| Thành phần | Công nghệ |
|-----------|----------|
| Framework | Flutter |
| Ngôn ngữ | Dart |
| Database | SQLite |
| UI Design | Figma |

---

## Giao diện chính

- Login Screen
- Home (Today Schedule)
- Add / Edit Schedule
- All Schedule List

---

---

## Cài đặt và chạy dự án

### 1. Clone project

```bash
git clone https://github.com/nguyenkhanhpro/study_schedule_reminder.git
```

### 2. Cài dependencies
```bash
flutter pub get
```

### 3. Chạy ứng dụng
```bash
flutter run
```

### Hướng phát triển
- Đồng bộ dữ liệu với Firebase
- Thêm đăng nhập Google
- Thêm calendar view
- Thống kê thời gian học
- Hỗ trợ đa thiết bị

### Ghi chú
- Ứng dụng hoạt động offline
- Dữ liệu lưu cục bộ trên thiết bị
- Phù hợp cho mục đích học tập / đồ án
